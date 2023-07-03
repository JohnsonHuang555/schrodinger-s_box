import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class CongratulationsModal {
  static void createModal(BuildContext context, String answer) {
    Dialogs.materialDialog(
      title: 'congrats'.tr(),
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      color: Color.fromARGB(255, 234, 238, 241),
      customView: Column(
        children: [
          Text(
            'your_new_score'.tr(),
            style: TextStyle(
              fontFamily: 'Saira',
              fontSize: 18,
            ),
          ),
          Text(
            answer,
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Saira',
            ),
          ),
        ],
      ),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      barrierDismissible: false,
      lottieBuilder: Lottie.asset(
        'assets/animations/congrats.json',
        fit: BoxFit.contain,
      ),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacement('/play');
          },
          text: 'return_menu'.tr(),
          iconData: Icons.arrow_back_rounded,
          textStyle: TextStyle(color: Colors.blueGrey),
          iconColor: Colors.blueGrey,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            GoRouter.of(context).pushReplacement('/playSession');
          },
          text: 'play_again'.tr(),
          iconData: Icons.replay,
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Color.fromARGB(255, 234, 238, 241)),
          iconColor: Color.fromARGB(255, 234, 238, 241),
        ),
      ],
    );
  }
}
