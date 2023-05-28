import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class AlertPickItemModal {
  static void createModal(BuildContext context) {
    Dialogs.materialDialog(
      msg: 'Choose at least one item',
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      msgStyle: TextStyle(
        fontFamily: 'Saira',
        fontSize: 16,
      ),
      title: 'Alert',
      color: Color.fromARGB(255, 234, 238, 241),
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'OK',
          color: Colors.deepOrange,
          textStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
