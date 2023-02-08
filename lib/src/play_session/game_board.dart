import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/play_session/game_card.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: ((context, state, child) {
        return GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: state.currentSymbols
              .map((symbol) => GameCard(symbol: symbol))
              .toList(),
        );
      }),
    );
  }
}
