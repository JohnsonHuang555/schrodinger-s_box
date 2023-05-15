import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class CalculateAnswerModal {
  static void createModal(BuildContext context, VoidCallback confirm) {
    Dialogs.materialDialog(
      title: 'Congratulations !',
      titleStyle: TextStyle(
        fontSize: 20,
        fontFamily: 'Saira',
      ),
      color: Color.fromARGB(255, 234, 238, 241),
      customView: Column(
        children: [
          Text(
            'your new score',
            style: TextStyle(
              fontFamily: 'Saira',
            ),
          ),
          Text(
            '500',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Saira',
            ),
          ),
        ],
      ),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      lottieBuilder: Lottie.asset(
        'assets/animations/congrats.json',
        fit: BoxFit.contain,
      ),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'Return Menu',
          iconData: Icons.arrow_back_rounded,
          textStyle: TextStyle(color: Colors.blueGrey),
          iconColor: Colors.blueGrey,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 800), () {
              confirm();
            });
          },
          text: 'Play Again',
          iconData: Icons.replay,
          color: Colors.deepOrange,
          textStyle: TextStyle(color: Color.fromARGB(255, 234, 238, 241)),
          iconColor: Color.fromARGB(255, 234, 238, 241),
        ),
      ],
    );
  }
}
