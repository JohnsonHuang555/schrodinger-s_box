import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CloseGameModal {
  static void createModal(BuildContext context) {
    Dialogs.materialDialog(
      msg: 'exit_hint'.tr(),
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      msgStyle: TextStyle(
        fontFamily: 'Saira',
        fontSize: 18,
      ),
      title: 'exit'.tr(),
      color: Color.fromARGB(255, 234, 238, 241),
      context: context,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'no'.tr(),
          textStyle: TextStyle(color: Colors.grey),
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          text: 'yes'.tr(),
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
