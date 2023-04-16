import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_risk.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';

class GameCard<T> extends StatefulWidget {
  final int index;
  final T item;
  final List<SelectedItem> selectedItems;
  final bool isSymbol;
  final dynamic onTap;
  const GameCard({
    super.key,
    required this.index,
    required this.item,
    required this.selectedItems,
    required this.isSymbol,
    required this.onTap,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    if (widget.selectedItems.isEmpty) {
      setState(() {
        isChecked = false;
      });
    }

    SelectedItem alreadySelected;
    if (widget.isSymbol) {
      alreadySelected = widget.selectedItems.singleWhere(
          (element) => element.index == widget.index && element.symbol != null,
          orElse: () => SelectedItem(index: -1));
    } else {
      alreadySelected = widget.selectedItems.singleWhere(
          (element) => element.index == widget.index && element.number != null,
          orElse: () => SelectedItem(index: -1));
    }

    if (alreadySelected.index != -1) {
      setState(() {
        isChecked = true;
      });
    } else {
      setState(() {
        isChecked = false;
      });
    }

    return InkResponse(
      onTap: () {
        widget.onTap(index: widget.index, item: widget.item);
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(3.0),
              child: Center(
                child: widget.isSymbol
                    ? Icon(
                        GameRisk.convertSymbolToIcon(widget.item as MathSymbol),
                        color: Colors.white,
                        size: 40.0,
                      )
                    : Text(
                        GameRisk.isInteger(widget.item as double)
                            ? (widget.item as double).toInt().toString()
                            : widget.item.toString(),
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: palette.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: isChecked
                    ? Icon(
                        Icons.check,
                        size: 50,
                      )
                    : null),
          ),
        ],
      ),
    );
  }
}
