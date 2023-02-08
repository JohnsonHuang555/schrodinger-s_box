import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  final MathSymbol symbol;
  const GameCard({super.key, required this.symbol});

  IconData? GetIcon() {
    switch (symbol) {
      case MathSymbol.plus:
        return Icons.add;
      case MathSymbol.minus:
        return Icons.remove;
      case MathSymbol.times:
        return Icons.close;
      case MathSymbol.divide:
        return Icons.safety_divider;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Provider.of<GameState>(context, listen: false).selectSymbol(symbol);
      },
      child: Center(
        child: Container(
          color: Colors.blue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(3.0),
            child: Center(
              child: Icon(
                GetIcon(),
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
