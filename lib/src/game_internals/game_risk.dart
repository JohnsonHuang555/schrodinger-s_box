import 'package:game_template/src/game_internals/game_state.dart';

class GameRisk {
  List<MathSymbol> risk1() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 5);
    var minusSymbol = _createSymbol(MathSymbol.minus, 4);
    return [...plusSymbol, ...minusSymbol];
  }

  List<T> _createSymbol<T>(T symbol, int count) {
    List<T> arr = [];
    for (var i = 0; i < count; i++) {
      arr.add(symbol);
    }
    return arr;
  }
}
