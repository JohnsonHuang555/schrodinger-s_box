import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_template/src/components/modals/alert_pick_item_modal.dart';
import 'package:game_template/src/components/modals/congratulations_modal.dart';
import 'package:game_template/src/components/modals/confirm_submit_modal.dart';
import 'package:game_template/src/components/modals/pick_item_modal.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:game_template/src/play_session/confirm_dialog.dart';
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
  final VoidCallback clearAnswer;
  final Function(SelectedItem item) onAnswerSelect;
  final List<SelectedItem> currentFormulaItems;
  const ControlArea({
    super.key,
    required this.step,
    required this.selectedItems,
    required this.nextStep,
    required this.onAnswerSelect,
    required this.currentFormulaItems,
    required this.clearAnswer,
  });

  List<Widget> getAnswerCard(Palette palette) {
    return List.generate(8, (index) {
      var noItem = index > selectedItems.length - 1;
      if (noItem) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 168, 176, 191),
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }
      var isSelect = currentFormulaItems.singleWhere(
          (item) => item.id == selectedItems[index].id,
          orElse: () => SelectedItem(id: '', index: -1));
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
            border: isSelect.id != ''
                ? Border.all(
                    width: 6,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )
                : null,
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
          child: Row(
            children: [
              step == 3
                  ? Expanded(
                      child: FancyButton.icon(
                        padding: EdgeInsets.all(6.5),
                        color: Colors.deepOrange,
                        onPressed: () {
                          clearAnswer();
                        },
                        icon: Icons.delete,
                        elevation: 8,
                      ),
                    )
                  : Expanded(flex: 0, child: Container()),
              SizedBox(
                width: step == 3 ? 10 : 0,
              ),
              Expanded(
                flex: step == 3 ? 3 : 1,
                child: FancyButton.text(
                  color: Colors.blueGrey,
                  onPressed: () {
                    if (step == 1 || step == 2) {
                      if (step == 1) {
                        // FIXME: 重複的 code
                        // 已選擇的符號
                        var currentSelectedSymbolCount = selectedItems
                            .where((element) => element.symbol != null)
                            .length;
                        if (currentSelectedSymbolCount == 0) {
                          AlertPickItemModal.createModal(context);
                          return;
                        }
                      } else if (step == 2) {
                        // 已選擇的數字
                        var currentSelectedNumberCount = selectedItems
                            .where((element) => element.number != null)
                            .length;
                        if (currentSelectedNumberCount == 0) {
                          AlertPickItemModal.createModal(context);
                          return;
                        }
                      }
                      PickItemModal.createModal(context, nextStep);
                    } else if (step == 3) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        ConfirmSubmitModal.createModal(context);
                      });
                    }
                  },
                  text: step == 3 ? 'SUBMIT' : 'NEXT',
                  elevation: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
