import 'package:game_template/src/game_internals/game_state.dart';

class GameRisk {
  List<MathSymbol> risk1() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 5);
    var minusSymbol = _createSymbol(MathSymbol.minus, 4);
    return [...plusSymbol, ...minusSymbol];
  }

  List<MathSymbol> risk2() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 3);
    var minusSymbol = _createSymbol(MathSymbol.minus, 5);
    var timesSymbol = _createSymbol(MathSymbol.times, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol];
  }

  List<MathSymbol> risk3() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 3);
    var minusSymbol = _createSymbol(MathSymbol.minus, 4);
    var timesSymbol = _createSymbol(MathSymbol.times, 1);
    var divideSymbol = _createSymbol(MathSymbol.divide, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  List<T> _createSymbol<T>(T symbol, int count) {
    List<T> arr = [];
    for (var i = 0; i < count; i++) {
      arr.add(symbol);
    }
    return arr;
  }
}
