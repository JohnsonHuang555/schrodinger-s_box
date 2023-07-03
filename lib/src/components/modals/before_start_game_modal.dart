import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class BeforeStartGameModal {
  static void createModal(BuildContext context) {
    Dialogs.materialDialog(
      title: 'rules'.tr(),
      titleStyle: TextStyle(
        fontFamily: 'Saira',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      customView: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'rules_1',
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: 17,
              ),
            ).tr(),
            Text(
              'rules_2',
              style: TextStyle(
                fontFamily: 'Saira',
                fontSize: 17,
              ),
            ).tr(),
            SizedBox(
              height: 10,
            ),
            Text(
              'rules_step_1',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Saira',
              ),
            ).tr(),
            Text(
              'rules_step_2',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Saira',
              ),
            ).tr(),
            Text(
              'rules_step_3',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Saira',
              ),
            ).tr(),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'are_you_ready',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Saira',
                ),
              ).tr(),
            ),
          ],
        ),
      ),
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
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
            GoRouter.of(context).push('/playSession');
          },
          text: 'yes'.tr(),
          color: Colors.blueGrey,
          textStyle: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
