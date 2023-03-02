import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:game_template/src/play_session/game_card.dart';

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

  List<Widget> getGameCard() {
    return List.generate(
      items.length,
      (index) => GameCard(
        index: index,
        item: items[index],
        isSymbol: isSymbol,
        selectedItems: selectedItems,
        onTap: onSelect,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      crossAxisCount: 3,
      children: getGameCard(),
    );
  }
}
