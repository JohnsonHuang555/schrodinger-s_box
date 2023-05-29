import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

import '../../player_progress/player_progress.dart';

/// 建立玩家資料 Modal
class CreateUserModal {
  static void createModal(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    Dialogs.materialDialog(
      title: 'Enter your name',
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
              labelText: 'Your name',
              labelStyle: TextStyle(
                fontFamily: 'Saira',
              )),
          controller: _controller,
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
            context.read<PlayerProgress>().savePlayerName();
          },
        ),
      ),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      context: context,
      barrierDismissible: false,
      actions: [
        IconsButton(
          onPressed: () {
            var value = context.read<PlayerProgress>().playerName;
            if (value == '') {
              return;
            }
            Navigator.of(context).pop();
            Future.delayed(Duration(milliseconds: 800), () {
              context.read<PlayerProgress>().savePlayerName();
            });
          },
          text: 'OK',
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Color.fromARGB(255, 234, 238, 241)),
        ),
      ],
    );
  }
}
