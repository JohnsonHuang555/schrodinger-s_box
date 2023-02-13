import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_risk.dart';
import 'package:game_template/src/game_internals/game_state.dart';
import 'package:game_template/src/game_internals/selected_symbol.dart';
import 'package:provider/provider.dart';

class GameCard extends StatefulWidget {
  final int index;
  final MathSymbol symbol;
  const GameCard({
    super.key,
    required this.index,
    required this.symbol,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    var selectedSymbols = Provider.of<GameState>(context).selectedSymbols;
    if (selectedSymbols.isEmpty) {
      setState(() {
        isChecked = false;
      });
    }

    var alreadySelected = selectedSymbols.singleWhere(
        (element) => element.index == widget.index,
        orElse: () => SelectedSymbol(-1, null));

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
        Provider.of<GameState>(context, listen: false)
            .selectSymbol(widget.index, widget.symbol);
      },
      child: Consumer<GameState>(builder: (context, state, child) {
        return Stack(
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
                    child: Icon(
                      GameRisk.convertSymbolToIcon(widget.symbol),
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.blueAccent,
              child: Center(
                  child: isChecked
                      ? Icon(
                          Icons.check,
                          size: 30,
                        )
                      : null),
            ),
          ],
        );
      }),
    );
  }
}
