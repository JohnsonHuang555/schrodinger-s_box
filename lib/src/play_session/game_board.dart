import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      (index) => AnimationConfiguration.staggeredGrid(
        position: index,
        duration: const Duration(milliseconds: 375),
        columnCount: 3,
        child: ScaleAnimation(
          child: FadeInAnimation(
            child: GameCard(
              index: index,
              item: items[index],
              isSymbol: isSymbol,
              selectedItems: selectedItems,
              onTap: onSelect,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 3,
        children: getGameCard(),
      ),
    );
  }
}
