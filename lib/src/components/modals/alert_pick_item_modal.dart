import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class AlertPickItemModal {
  static void createModal(BuildContext context, String title) {
    Dialogs.materialDialog(
      msg: title,
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      msgStyle: TextStyle(
        fontFamily: 'Saira',
        fontSize: 18,
      ),
      title: 'alert'.tr(),
      color: Color.fromARGB(255, 234, 238, 241),
      context: context,
      actions: [
        Container(),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'OK',
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
        ),
        Container(),
      ],
    );
  }
}
