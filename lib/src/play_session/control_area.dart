import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../components/fancy_button.dart';

/// 提示與操作區塊
class ControlArea extends StatelessWidget {
  final List<IconData> content;
  final List<SelectedItem> selectedItems;
  final int currentSelectedSymbolCount;
  final int step;
  final VoidCallback nextStep;
  const ControlArea({
    super.key,
    required this.content,
    required this.currentSelectedSymbolCount,
    required this.step,
    required this.selectedItems,
    required this.nextStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // Text(
        //   _getDescription(),
        //   style: TextStyle(fontSize: 14),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // (step == 1 || step == 2)
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             '內容物',
        //             style: TextStyle(fontSize: 20),
        //           ),
        //           SizedBox(
        //             height: 10,
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: content
        //                 .map(
        //                   (icon) => Icon(
        //                     icon,
        //                     size: 30.0,
        //                   ),
        //                 )
        //                 .toList(),
        //           )
        //         ],
        //       )
        //     : Container(),
        // 確認視窗
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          child: FancyButton.text(
            color: Colors.blueGrey,
            onPressed: () {
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
            },
            text: 'NEXT',
            elevation: 8,
          ),
        ),
      ],
    );
  }
}
