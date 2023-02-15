import 'package:flutter/material.dart';

class ContentHint extends StatelessWidget {
  final List<IconData> content;
  final int currentSelectedSymbolCount;
  final int step;
  const ContentHint({
    super.key,
    required this.content,
    required this.currentSelectedSymbolCount,
    required this.step,
  });

  String _getDescription() {
    switch (step) {
      case 1:
        return '請選擇至少 1 個最多 3 個';
      case 2:
        return '請選擇 $currentSelectedSymbolCount 個';
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
    );
  }
}
