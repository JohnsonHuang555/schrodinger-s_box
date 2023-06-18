import 'package:flutter/material.dart';
import 'package:game_template/src/components/modals/alert_pick_item_modal.dart';
import 'package:game_template/src/components/modals/congratulations_modal.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../../player_progress/player_progress.dart';

class ConfirmSubmitModal {
  static void createModal(BuildContext context) {
    Dialogs.materialDialog(
      msg: 'Are you sure to submit ?',
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      msgStyle: TextStyle(
        fontFamily: 'Saira',
        fontSize: 18,
      ),
      title: 'Calculate',
      color: Color.fromARGB(255, 234, 238, 241),
      context: context,
      actions: [
        IconsOutlineButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: 'No',
          textStyle: TextStyle(color: Colors.grey),
        ),
        IconsButton(
          onPressed: () {
            Navigator.of(context).pop();
            var yourScore = context.read<PlayerProgress>().yourScore;
            var answer = context.read<GameState>().getCurrentAnswer(yourScore);
            if (answer == '?' || answer == 'x') {
              AlertPickItemModal.createModal(context, 'Format is wrong');
              return;
            }
            var result = context.read<PlayerProgress>().saveNewScore(answer);
            result.then((value) {
              if (value) {
                CongratulationsModal.createModal(context, answer);
              } else {
                throw StateError('error! confirm modal');
              }
            });
          },
          text: 'Yes',
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
