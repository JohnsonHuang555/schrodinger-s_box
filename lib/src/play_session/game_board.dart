import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:game_template/src/play_session/game_card.dart';
import 'package:provider/provider.dart';

class GameBoard<T> extends StatelessWidget {
  final List<T> items;
  final bool isSymbol;
  final List<SelectedItem> selectedItems;
  final dynamic onSelect;
  const GameBoard({
    super.key,
    required this.items,
    required this.isSymbol,
    required this.selectedItems,
    required this.onSelect,
  });

  List<Widget> getGameCard(List<T> items) {
    var cards = List.generate(items.length, (index) {
      return GameCard(
        index: index,
        item: items[index],
        isSymbol: isSymbol,
        selectedItems: selectedItems,
        onTap: onSelect,
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
            children: getGameCard(items));
      }),
    );
  }
}
