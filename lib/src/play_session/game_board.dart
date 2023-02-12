import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/play_session/game_card.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  List<Widget> getGameCard(List<MathSymbol> symbols) {
    var cards = List.generate(symbols.length, (index) {
      return GameCard(
        index: index,
        symbol: symbols[index],
      );
    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: ((context, state, child) {
        return GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 3,
            children: getGameCard(state.currentSymbols));
      }),
    );
  }
}
