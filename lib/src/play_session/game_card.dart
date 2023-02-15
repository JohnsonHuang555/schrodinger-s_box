import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';

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

  IconData? convertSymbolToIcon(MathSymbol symbol) {
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

  bool _isInteger(double value) => value == value.toInt();

  @override
  Widget build(BuildContext context) {
    if (widget.selectedItems.isEmpty) {
      setState(() {
        isChecked = false;
      });
    }

    var alreadySelected = widget.selectedItems.singleWhere(
        (element) => element.index == widget.index,
        orElse: () => SelectedItem(index: -1));

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
              color: Colors.blue,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(3.0),
                child: Center(
                  child: widget.isSymbol
                      ? Icon(
                          convertSymbolToIcon(widget.item as MathSymbol),
                          color: Colors.white,
                          size: 40.0,
                        )
                      : Text(
                          _isInteger(widget.item as double)
                              ? (widget.item as double).toInt().toString()
                              : widget.item.toString(),
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ),
                ),
              ),
            ),
          ),
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   color: Colors.blueAccent,
          //   child: Center(
          //       child: isChecked
          //           ? Icon(
          //               Icons.check,
          //               size: 30,
          //             )
          //           : null),
          // ),
        ],
      ),
    );
  }
}
