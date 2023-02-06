import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  final MathSymbol symbol;
  const GameCard({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Provider.of<GameState>(context, listen: false).selectSymbol(symbol);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: Colors.blue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(3.0),
            child: Center(child: Text(symbol.toString())),
          ),
        ),
      ),
    );
  }
}
