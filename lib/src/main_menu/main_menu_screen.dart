// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/games_services.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final gamesServicesController = context.watch<GamesServicesController?>();
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return ScaffoldGradientBackground(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF7d8ca8),
          Color.fromARGB(255, 94, 107, 132),
        ],
      ),
      body: ResponsiveScreen(
          mainAreaProminence: 0.45,
          squarishMainArea: Center(
            child: SizedBox(
              width: 200,
              child: Image.asset(
                'assets/images/logo.png',
                semanticLabel: 'LOGO',
              ),
            ),
          ),
          rectangularMenuArea: SizedBox(
            height: 280,
            child: GestureDetector(
              onTap: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).go('/play');
              },
              child: Animate(
                  child: Text(
                'TAP  TO  PLAY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  letterSpacing: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
                      .animate(
                        delay: 100
                            .ms, // this delay only happens once at the very start
                        onPlay: (controller) => controller.repeat(), // loop
                      )
                      .fadeIn(
                          duration: 1000
                              .ms) // this delay happens at the start of each loop
                      .fadeOut(delay: 500.ms)),
            ),
          )
          //   Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         audioController.playSfx(SfxType.buttonTap);
          //         GoRouter.of(context).go('/play');
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         // Change button text when light changes state.
          //         child: Text(
          //           'TAP TO PLAY',
          //           style: TextStyle(fontSize: 20, letterSpacing: 1.5),
          //         ),
          //       ),
          //     ),
          //     // InkResponse(
          //     //   highlightShape: BoxShape.rectangle,
          //     //   onTap: () {
          //     //     audioController.playSfx(SfxType.buttonTap);
          //     //     GoRouter.of(context).go('/play');
          //     //   },
          //     //   child: const Text(
          //     //     'TAP TO PLAY',
          //     //     style: TextStyle(fontSize: 20, letterSpacing: 1.5),
          //     //   ),
          //     // ),
          //     SizedBox(
          //       height: 350,
          //     )
          //     // if (gamesServicesController != null) ...[
          //     //   _hideUntilReady(
          //     //     ready: gamesServicesController.signedIn,
          //     //     child: ElevatedButton(
          //     //       onPressed: () => gamesServicesController.showAchievements(),
          //     //       child: const Text('Achievements'),
          //     //     ),
          //     //   ),
          //     //   _gap,
          //     //   _hideUntilReady(
          //     //     ready: gamesServicesController.signedIn,
          //     //     child: ElevatedButton(
          //     //       onPressed: () => gamesServicesController.showLeaderboard(),
          //     //       child: const Text('Leaderboard'),
          //     //     ),
          //     //   ),
          //     //   _gap,
          //     // ],
          //     // ElevatedButton(
          //     //   onPressed: () => GoRouter.of(context).push('/settings'),
          //     //   child: const Text('Settings'),
          //     // ),
          //     // _gap,
          //     // Padding(
          //     //   padding: const EdgeInsets.only(top: 32),
          //     //   child: ValueListenableBuilder<bool>(
          //     //     valueListenable: settingsController.muted,
          //     //     builder: (context, muted, child) {
          //     //       return IconButton(
          //     //         onPressed: () => settingsController.toggleMuted(),
          //     //         icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
          //     //       );
          //     //     },
          //     //   ),
          //     // ),
          //     // _gap,
          //     // const Text('Music by Mr Smith'),
          //     // _gap,
          //   ],
          // ),
          ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

  static const _gap = SizedBox(height: 10);
}
