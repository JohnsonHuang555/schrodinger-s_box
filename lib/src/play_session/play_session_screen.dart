// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_template/src/components/modals/leave_playing_modal.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/play_session/control_area.dart';
import 'package:game_template/src/play_session/game_board.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../ads/ads_controller.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/game_risk.dart';
import '../games_services/games_services.dart';
import '../in_app_purchase/in_app_purchase.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';

class PlaySessionScreen extends StatefulWidget {
  // final GameLevel level;

  const PlaySessionScreen({super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen>
    with WidgetsBindingObserver {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  late BuildContext appContext;

  List<Widget> _getBlackboardItems(GameState state, Palette palette) {
    var yourScore = context.read<PlayerProgress>().yourScore;

    List<Widget> items = [
      Text(
        yourScore,
        style: TextStyle(
          color: palette.trueWhite,
          fontSize: 32,
          fontFamily: 'Darumadrop',
        ),
      ),
      SizedBox(
        width: 8,
      ),
    ];
    for (var item in state.currentFormulaItems) {
      if (item.symbol != null) {
        switch (item.symbol) {
          case MathSymbol.plus:
            items.add(FaIcon(
              FontAwesomeIcons.plus,
              color: palette.trueWhite,
              size: 26,
            ));
            break;
          case MathSymbol.minus:
            items.add(FaIcon(
              FontAwesomeIcons.minus,
              color: palette.trueWhite,
              size: 26,
            ));
            break;
          case MathSymbol.times:
            items.add(FaIcon(
              FontAwesomeIcons.xmark,
              color: palette.trueWhite,
              size: 26,
            ));
            break;
          case MathSymbol.divide:
            items.add(FaIcon(
              FontAwesomeIcons.divide,
              color: palette.trueWhite,
              size: 26,
            ));
            break;
          default:
        }
      } else {
        if (GameRisk.isInteger(item.number as double)) {
          items.add(
            Text(
              (item.number as double).toInt().toString(),
              style: TextStyle(
                color: palette.trueWhite,
                fontSize: 30,
                fontFamily: 'Darumadrop',
              ),
            ),
          );
        } else {
          items.add(
            Text(
              item.number.toString(),
              style: TextStyle(
                color: palette.trueWhite,
                fontSize: 30,
                fontFamily: 'Darumadrop',
              ),
            ),
          );
        }
      }
      items.add(SizedBox(
        width: 8,
      ));
    }
    return items;
  }

  Widget _getGameBoard(GameState state, Palette palette) {
    var yourScore = context.read<PlayerProgress>().yourScore;

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
          showChooseResult: state.showChooseResult,
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
          showChooseResult: state.showChooseResult,
        );
      case 3:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(225, 127, 155, 121),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: _getBlackboardItems(state, palette),
                  ),
                ),
              ),
            ),
            Text(
              '= ${state.getCurrentAnswer(yourScore)}',
              style: TextStyle(fontSize: 40),
            ),
          ],
        );
      default:
        return Text('Something wrong...');
    }
  }

  String _getDescription(int step) {
    switch (step) {
      case 1:
        return 'choose_symbols'.tr();
      case 2:
        return 'choose_numbers'.tr();
      case 3:
        return 'combine_math_formula'.tr();
      default:
        return 'Something wrong...';
    }
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameState(),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.primary,
          body: WillPopScope(
            onWillPop: () async {
              var shouldExist = await LeavePlayingModal.createModal(context);
              return shouldExist;
            },
            child: SafeArea(
              child: Stack(
                children: [
                  Consumer<GameState>(builder: ((context, state, child) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        // 關卡風險
                        Text(
                          'risk',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(args: [state.risk.toString()]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _getDescription(state.step),
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // 盒子
                        Expanded(
                          flex: state.step == 3 ? 1 : 2,
                          child: _getGameBoard(state, palette),
                        ),
                        // 內容物
                        Expanded(
                          child: ControlArea(
                            selectedItems: state.selectedItems,
                            step: state.step,
                            nextStep: state.nextStep,
                            currentFormulaItems: state.currentFormulaItems,
                            onAnswerSelect: (item) {
                              state.selectAnswer(item);
                            },
                            clearAnswer: () {
                              state.clearAnswer();
                            },
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Preload ad for the win screen.
    final adsRemoved =
        context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    if (!adsRemoved) {
      final adsController = context.read<AdsController?>();
      adsController?.preloadAd();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      LeavePlayingModal.deductTotalScore(appContext);
    }
  }

  Future<void> _playerWon() async {
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
