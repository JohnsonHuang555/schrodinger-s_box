import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../../player_progress/player_progress.dart';
import '../../style/palette.dart';

/// 建立玩家資料 Modal
class EditUserModal {
  static void createModal(BuildContext context) {
    final palette = context.read<Palette>();
    final TextEditingController controller = TextEditingController();

    var errorSnackBar = SnackBar(
      content: Text('error_name_exist').tr(),
      backgroundColor: palette.alert,
    );

    Dialogs.materialDialog(
      title: 'enter_your_name'.tr(),
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      color: Color.fromARGB(255, 234, 238, 241),
      customView: SizedBox(
        width: 280,
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'your_name'.tr(),
            labelStyle: TextStyle(
              fontFamily: 'Saira',
            ),
          ),
          controller: controller,
          autofocus: true,
          maxLength: 12,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            if (value == '') {
              return;
            }
            context.read<PlayerProgress>().setPlayerName(value);
          },
          onSubmitted: (value) {
            if (value == '') {
              return;
            }
            Navigator.pop(context);
            context.read<PlayerProgress>().editPlayerName().then((success) {
              if (success) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
              }
            });
          },
        ),
      ),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      context: context,
      barrierDismissible: false,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'cancel'.tr(),
          textStyle: TextStyle(color: Colors.grey),
        ),
        IconsButton(
          onPressed: () {
            var editedPlayerName =
                context.read<PlayerProgress>().editedPlayerName;
            if (editedPlayerName == '') {
              return;
            }
            context.read<PlayerProgress>().editPlayerName().then((success) {
              if (success) {
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
              }
            });
          },
          text: 'ok'.tr(),
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Color.fromARGB(255, 234, 238, 241)),
        ),
      ],
    );
  }
}
