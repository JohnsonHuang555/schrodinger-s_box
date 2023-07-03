import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../../player_progress/player_progress.dart';

class LeavePlayingModal {
  static Future<bool> createModal(BuildContext context) async {
    var confirm = false;
    await Dialogs.materialDialog(
      msg: 'leave_playing_desc'.tr(),
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
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context).pop();
            confirm = false;
          },
          text: 'no'.tr(),
          textStyle: TextStyle(color: Colors.grey),
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            deductTotalScore(context);
            confirm = true;
          },
          text: 'yes'.tr(),
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
    return confirm;
  }

  static void deductTotalScore(BuildContext context) {
    var playerProgress = context.read<PlayerProgress>();
    var yourNewScore = double.parse(playerProgress.yourScore).round() * 0.95;
    var result = playerProgress.saveNewScore(yourNewScore.round().toString());
    result.then((value) {
      if (!value) {
        throw StateError('error! confirm modal');
      }
    });
  }
}
