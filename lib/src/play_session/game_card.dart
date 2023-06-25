import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final bool showChooseResult;
  const GameCard({
    super.key,
    required this.index,
    required this.item,
    required this.selectedItems,
    required this.isSymbol,
    required this.onTap,
    required this.showChooseResult,
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
                color: palette.secondary,
                borderRadius: BorderRadius.circular(10),
                border: isChecked
                    ? Border.all(
                        width: 6,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    : null,
              ),
              margin: EdgeInsets.all(3.0),
              child: Center(
                child: widget.isSymbol
                    ? FaIcon(
                        GameRisk.convertSymbolToIcon(widget.item as MathSymbol),
                        color: palette.trueWhite,
                        size: 40,
                      )
                    : Text(
                        GameRisk.isInteger(widget.item as double)
                            ? (widget.item as double).toInt().toString()
                            : widget.item.toString(),
                        style: TextStyle(
                          fontSize: 36,
                          color: palette.trueWhite,
                        ),
                      ),
              ),
            ),
          ),
          !widget.showChooseResult
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: palette.secondary,
                    borderRadius: BorderRadius.circular(10),
                    border: isChecked
                        ? Border.all(
                            width: 6,
                            color: Color.fromARGB(255, 246, 246, 246),
                          )
                        : null,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
