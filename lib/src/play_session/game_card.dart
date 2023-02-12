import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/game_risk.dart';
import 'package:game_template/src/game_internals/game_state.dart';
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
    print("repaint");
    var selectedSymbols = Provider.of<GameState>(context).selectedSymbols;
    // var a = selectedSymbols.every((element) => element.index == widget.index);
    for (var element in selectedSymbols) {
      if (element.index == widget.index) {
        setState(() {
          isChecked = true;
        });
      }
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
