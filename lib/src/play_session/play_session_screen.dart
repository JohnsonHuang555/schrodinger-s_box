// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/play_session/control_area.dart';
import 'package:game_template/src/play_session/game_board.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../ads/ads_controller.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/game_risk.dart';
import '../game_internals/level_state.dart';
import '../games_services/games_services.dart';
import '../games_services/score.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';

class PlaySessionScreen extends StatefulWidget {
  // final GameLevel level;

  const PlaySessionScreen({super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late DateTime _startOfPlay;

  Widget _getGameBoard(GameState state) {
    switch (state.step) {
      case 1:
        return GameBoard<MathSymbol>(
          items: state.mathSymbols,
          selectedItems: state.selectedItems,
          isSymbol: true,
          onSelect: ({dynamic index, dynamic item}) {
            state.selectItem(
              index: index as int,
              symbol: item as MathSymbol,
            );
          },
        );
      case 2:
        return GameBoard<double>(
          items: state.numbers,
          selectedItems: state.selectedItems,
          isSymbol: false,
          onSelect: ({dynamic index, dynamic item}) {
            state.selectItem(
              index: index as int,
              number: item as double,
            );
          },
        );
      case 3:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '預覽: 100 + 1 + 2',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 100,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                buildDefaultDragHandles: false,
                children: <Widget>[
                  for (int index = 0;
                      index < state.selectedItems.length;
                      index += 1)
                    Container(
                      key: Key('$index'),
                      width: 100,
                      color: Colors.blue,
                      child: ReorderableDragStartListener(
                        index: index,
                        child: Card(
                          elevation: 2,
                          child: Center(
                            child: state.selectedItems[index].symbol != null
                                ? Icon(
                                    GameRisk.convertSymbolToIcon(state
                                        .selectedItems[index]
                                        .symbol as MathSymbol),
                                    size: 40.0,
                                  )
                                : Text(
                                    GameRisk.isInteger(state
                                            .selectedItems[index]
                                            .number as double)
                                        ? (state.selectedItems[index].number
                                                as double)
                                            .toInt()
                                            .toString()
                                        : state.selectedItems[index].number
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 36,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                ],
                onReorder: (oldIndex, newIndex) {
                  state.sortSelectedItem(oldIndex, newIndex);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '= ?',
              style: TextStyle(fontSize: 40),
            ),
          ],
        );
      default:
        return Text('Something wrong...');
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => LevelState(
        //     goal: widget.level.difficulty,
        //     onWin: _playerWon,
        //   ),
        // ),
        ChangeNotifierProvider(
          create: (context) => GameState(),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.secondary,
          body: SafeArea(
            child: Stack(
              children: [
                Consumer<GameState>(builder: ((context, state, child) {
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkResponse(
                          onTap: () => GoRouter.of(context).push('/settings'),
                          child: Image.asset(
                            'assets/images/settings.png',
                            semanticLabel: 'Settings',
                          ),
                        ),
                      ),
                      // 關卡風險
                      Text(
                        '風險 ${state.risk} - ${state.currentStep}',
                        style: TextStyle(fontSize: 24),
                      ),
                      // 盒子
                      Expanded(
                        flex: state.step == 3 ? 4 : 2,
                        child: _getGameBoard(state),
                      ),
                      // 內容物
                      Expanded(
                        child: ControlArea(
                          content: state.hint,
                          selectedItems: state.selectedItems,
                          currentSelectedSymbolCount: state.selectedItems
                              .where((element) => element.symbol != null)
                              .length,
                          step: state.step,
                          nextStep: state.nextStep,
                        ),
                      ),
                    ],
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _startOfPlay = DateTime.now();

    // Preload ad for the win screen.
    final adsRemoved =
        context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    if (!adsRemoved) {
      final adsController = context.read<AdsController?>();
      adsController?.preloadAd();
    }
  }

  Future<void> _playerWon() async {
    // _log.info('Level ${widget.level.number} won');

    // final score = Score(
    //   widget.level.number,
    //   widget.level.difficulty,
    //   DateTime.now().difference(_startOfPlay),
    // );

    final playerProgress = context.read<PlayerProgress>();
    // playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.congrats);

    final gamesServicesController = context.read<GamesServicesController?>();
    if (gamesServicesController != null) {
      // Award achievement.
      // if (widget.level.awardsAchievement) {
      //   await gamesServicesController.awardAchievement(
      //     android: widget.level.achievementIdAndroid!,
      //     iOS: widget.level.achievementIdIOS!,
      //   );
      // }

      // Send score to leaderboard.
      // await gamesServicesController.submitLeaderboardScore(score);
    }

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    // GoRouter.of(context).go('/play/won', extra: {'score': score});
  }
}
