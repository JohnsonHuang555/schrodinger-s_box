// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_template/src/components/fancy_button.dart';
import 'package:game_template/src/components/modals/close_game_modal.dart';
import 'package:game_template/src/components/modals/create_user_modal.dart';
import 'package:game_template/src/game_internals/helpers.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale('zh', 'TW'));
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    if (playerProgress.showCreateUserModal) {
      Future.delayed(Duration(milliseconds: 1000), () {
        CreateUserModal.createModal(context);
      });
    }

    return Scaffold(
      backgroundColor: palette.primary,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                'score',
                style: TextStyle(
                  fontSize: 28,
                  color: Color.fromARGB(255, 33, 33, 33),
                  fontFamily: 'Saira',
                  fontWeight: FontWeight.w500,
                ),
              ).tr(),
            ),
            Center(
              child: Text(
                playerProgress.yourScore,
                style: TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 33, 33, 33),
                  fontFamily: 'Saira',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.crown,
                  size: 24,
                  color: Color.fromARGB(255, 186, 121, 16),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Helpers.getOrdinalSuffix(playerProgress.yourRank),
                  style: TextStyle(
                    fontSize: 26,
                    color: Color.fromARGB(255, 131, 84, 7),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Saira',
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: Animate(
                      child: FancyButton.text(
                        color: Colors.blueGrey,
                        onPressed: () {
                          // Future.delayed(Duration(milliseconds: 100), () {
                          GoRouter.of(context).push('/playSession');
                          // });
                        },
                        text: 'PLAY',
                        elevation: 8,
                      ),
                    ).animate().fadeIn(delay: 1000.ms),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: Animate(
                      child: FancyButton.text(
                        color: Colors.blueGrey,
                        onPressed: () {
                          // Future.delayed(Duration(milliseconds: 300), () {
                          // GoRouter.of(context).push('/leaderboard');
                          // });
                        },
                        text: 'RULES',
                        elevation: 8,
                      ),
                    ).animate().fadeIn(delay: 1200.ms),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: Animate(
                      child: FancyButton.text(
                        color: Colors.blueGrey,
                        onPressed: () {
                          // Future.delayed(Duration(milliseconds: 300), () {
                          GoRouter.of(context).push('/leaderboard');
                          // });
                        },
                        text: 'LEADERBOARD',
                        elevation: 8,
                      ),
                    ).animate().fadeIn(delay: 1400.ms),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: Animate(
                      child: FancyButton.text(
                        color: Colors.blueGrey,
                        onPressed: () {
                          GoRouter.of(context).push('/settings');
                        },
                        text: 'SETTINGS',
                        elevation: 8,
                      ),
                    ).animate().fadeIn(delay: 1600.ms),
                  ),
                  Container(
                    width: 250,
                    margin: EdgeInsets.all(16),
                    child: Animate(
                      child: FancyButton.text(
                        color: Colors.blueGrey,
                        onPressed: () {
                          // throw StateError('whoa!');
                          CloseGameModal.createModal(context);
                        },
                        text: 'CLOSE',
                        elevation: 8,
                      ),
                    ).animate().fadeIn(delay: 1800.ms),
                  ),
                ],
              ),
            )
          ],
        ),
        rectangularMenuArea: Container(),
      ),
    );
  }
}
