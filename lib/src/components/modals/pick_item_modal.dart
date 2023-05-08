import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class PickItemModal {
  static void createModal(BuildContext context, VoidCallback nextStep) {
    Dialogs.materialDialog(
      msg: 'Are you sure to pick these ?',
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      msgStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      title: 'Confirm',
      color: Colors.white,
      context: context,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'No',
          iconData: Icons.clear,
          textStyle: TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 800), () {
              nextStep();
            });
          },
          text: 'Yes',
          iconData: Icons.check,
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
