import 'package:flutter/material.dart';

class SymbolsHint extends StatelessWidget {
  final List<IconData> symbols;
  const SymbolsHint({super.key, required this.symbols});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '請選擇至少一個最多三個',
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
          children: symbols
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
