// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/components/fancy_button.dart';
import 'package:game_template/src/components/modals/edit_user_modal.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../in_app_purchase/in_app_purchase.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.primary,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Text(
              'settings_screen',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            _gap,
            _NameChangeLine(
              'name',
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'sound_fx',
                Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                onSelected: () => settings.toggleSoundsOn(),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                'music',
                Icon(musicOn ? Icons.music_note : Icons.music_off),
                onSelected: () => settings.toggleMusicOn(),
              ),
            ),
            Consumer<InAppPurchaseController?>(
                builder: (context, inAppPurchase, child) {
              if (inAppPurchase == null) {
                // In-app purchases are not supported yet.
                // Go to lib/main.dart and uncomment the lines that create
                // the InAppPurchaseController.
                return const SizedBox.shrink();
              }

              Widget icon;
              VoidCallback? callback;
              if (inAppPurchase.adRemoval.active) {
                icon = const Icon(Icons.check);
              } else if (inAppPurchase.adRemoval.pending) {
                icon = const CircularProgressIndicator();
              } else {
                icon = const Icon(Icons.ad_units);
                callback = () {
                  inAppPurchase.buy();
                };
              }
              return _SettingsLine(
                'Remove ads',
                icon,
                onSelected: callback,
              );
            }),
            const _LanguageLine('language'),
          ],
        ),
        rectangularMenuArea: SizedBox(
          width: double.infinity,
          child: FancyButton.text(
            color: Colors.blueGrey,
            onPressed: () {
              GoRouter.of(context).pop();
            },
            text: 'back'.tr(),
            elevation: 8,
          ),
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgress>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => EditUserModal.createModal(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Saira',
                fontSize: 24,
              ),
            ).tr(),
            const Spacer(),
            Text(
              playerProgress.playerName,
              style: const TextStyle(
                fontFamily: 'Saira',
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Saira',
                fontSize: 24,
              ),
            ).tr(),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}

class _LanguageLine extends StatelessWidget {
  final String title;

  const _LanguageLine(this.title);

  @override
  Widget build(BuildContext context) {
    String currentLanguage = context.locale.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Saira',
              fontSize: 24,
            ),
          ).tr(),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                RadioListTile(
                  activeColor: Colors.blueGrey,
                  title: Text(
                    'English',
                    style: TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 20,
                    ),
                  ),
                  value: 'en_US',
                  groupValue: currentLanguage,
                  onChanged: (obj) {
                    context.setLocale(Locale('en', 'US'));
                  },
                ),
                RadioListTile(
                  activeColor: Colors.blueGrey,
                  title: Text(
                    '繁體中文',
                    style: TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 20,
                    ),
                  ),
                  value: 'zh_TW',
                  groupValue: currentLanguage,
                  onChanged: (obj) {
                    context.setLocale(Locale('zh', 'TW'));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
