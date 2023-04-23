// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:game_template/src/components/fancy_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.primary,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  '你的積分',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                '1000',
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
            const SizedBox(height: 80),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: FancyButton.text(
                      color: Colors.blueGrey,
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300), () {
                          GoRouter.of(context).push('/playSession');
                        });
                      },
                      text: '開始遊戲',
                      elevation: 8,
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: FancyButton.text(
                      color: Colors.blueGrey,
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300), () {
                          // GoRouter.of(context).push('/playSession');
                        });
                      },
                      text: '遊戲規則',
                      elevation: 8,
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: FancyButton.text(
                      color: Colors.blueGrey,
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300), () {
                          // GoRouter.of(context).push('/playSession');
                        });
                      },
                      text: '設定',
                      elevation: 8,
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: FancyButton.text(
                      color: Colors.blueGrey,
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300), () {
                          // GoRouter.of(context).push('/playSession');
                        });
                      },
                      text: '離開',
                      elevation: 8,
                    ),
                  ),
                ],
              ),
            )
            // Expanded(
            //   child: ListView(
            //     children: [
            //       for (final level in gameLevels)
            //         ListTile(
            //           enabled: playerProgress.highestLevelReached >=
            //               level.number - 1,
            //           onTap: () {
            //             final audioController = context.read<AudioController>();
            //             audioController.playSfx(SfxType.buttonTap);

            //             GoRouter.of(context)
            //                 .go('/play/session/${level.number}');
            //           },
            //           leading: Text(level.number.toString()),
            //           title: Text('Level #${level.number}'),
            //         )
            //     ],
            //   ),
            // ),
          ],
        ),
        // rectangularMenuArea: ElevatedButton(
        //   onPressed: () {
        //     GoRouter.of(context).go('/');
        //   },
        //   child: const Text('Back'),
        // ),
        rectangularMenuArea: Container(),
      ),
    );
  }
}
