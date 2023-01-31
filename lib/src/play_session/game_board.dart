import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Expanded(
          child: GridView.count(
        crossAxisCount: 3,
        children: [for (var i = 0; i < 9; i++) Text('${i}')],
      )),
    );
  }
}
