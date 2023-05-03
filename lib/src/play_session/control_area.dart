import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../components/fancy_button.dart';
import '../game_internals/game_risk.dart';
import '../game_internals/game_state.dart';
import '../style/palette.dart';

/// 提示與操作區塊
class ControlArea extends StatelessWidget {
  final List<SelectedItem> selectedItems;
  final int step;
  final VoidCallback nextStep;
  final Function(SelectedItem item) onAnswerSelect;
  const ControlArea({
    super.key,
    required this.step,
    required this.selectedItems,
    required this.nextStep,
    required this.onAnswerSelect,
  });

  List<Widget> getAnswerCard(Palette palette) {
    return List.generate(8, (index) {
      if (index > selectedItems.length - 1) {
        return Container(
          decoration: BoxDecoration(
            color: palette.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }
      return InkResponse(
        onTap: () {
          var uuid = Uuid();
          var id = uuid.v4();
          selectedItems[index].id = id;
          onAnswerSelect(selectedItems[index]);
        },
        child: Container(
          decoration: BoxDecoration(
            color: palette.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: selectedItems[index].symbol != null
              ? Center(
                  child: FaIcon(
                    GameRisk.convertSymbolToIcon(
                        selectedItems[index].symbol as MathSymbol),
                    color: palette.trueWhite,
                    size: 40,
                  ),
                )
              : Center(
                  child: Text(
                    GameRisk.isInteger(selectedItems[index].number as double)
                        ? (selectedItems[index].number as double)
                            .toInt()
                            .toString()
                        : selectedItems[index].number.toString(),
                    style: TextStyle(
                      fontSize: 36,
                      color: palette.trueWhite,
                    ),
                  ),
                ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Column(
      children: [
        step == 3
            ? GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: 4,
                children: getAnswerCard(palette),
              )
            : SizedBox(
                height: 110,
              ),
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
