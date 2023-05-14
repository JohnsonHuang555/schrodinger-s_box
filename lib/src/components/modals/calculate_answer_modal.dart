import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class CalculateAnswerModal {
  static void createModal(BuildContext context, VoidCallback confirm) {
    Dialogs.materialDialog(
      msg: 'Congratulations, you won 500 points',
      title: 'Congratulations',
      color: Colors.white,
      lottieBuilder: Lottie.asset(
        'assets/animations/congrats.json',
        fit: BoxFit.contain,
      ),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 800), () {
              confirm();
            });
          },
          text: 'OK',
          iconData: Icons.done,
          color: Colors.blue,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
