import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';

class ContentHint extends StatelessWidget {
  final List<IconData> content;
  final List<SelectedItem> selectedItems;
  final int currentSelectedSymbolCount;
  final int step;
  const ContentHint({
    super.key,
    required this.content,
    required this.currentSelectedSymbolCount,
    required this.step,
    required this.selectedItems,
  });

  String _getDescription() {
    switch (step) {
      case 1:
        return '請選擇至少 1 個最多 3 個';
      case 2:
        return '請選擇 $currentSelectedSymbolCount 個';
      case 3:
        return '請組合出最大值的算式';
      default:
        return 'Something wrong...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          _getDescription(),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 25,
        ),
        (step == 1 || step == 2)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '內容物',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: content
                        .map(
                          (icon) => Icon(
                            icon,
                            size: 30.0,
                          ),
                        )
                        .toList(),
                  )
                ],
              )
            : Row(
                children: selectedItems
                    .map((e) => Draggable(
                        feedback: Container(),
                        child: Container(
                          width: 60,
                          height: 90,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueAccent,
                          ),
                        )))
                    .toList(),
              ),
      ],
    );
  }
}
