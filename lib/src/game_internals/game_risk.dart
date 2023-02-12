import 'package:flutter/material.dart';
import './game_state.dart';

class GameRisk {
  static IconData? convertSymbolToIcon(MathSymbol symbol) {
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

  static List<MathSymbol> risk1() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 5);
    var minusSymbol = _createSymbol(MathSymbol.minus, 4);
    return [...plusSymbol, ...minusSymbol];
  }

  static List<MathSymbol> risk2() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 3);
    var minusSymbol = _createSymbol(MathSymbol.minus, 5);
    var timesSymbol = _createSymbol(MathSymbol.times, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol];
  }

  static List<MathSymbol> risk3() {
    var plusSymbol = _createSymbol(MathSymbol.plus, 3);
    var minusSymbol = _createSymbol(MathSymbol.minus, 4);
    var timesSymbol = _createSymbol(MathSymbol.times, 1);
    var divideSymbol = _createSymbol(MathSymbol.divide, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  static List<T> _createSymbol<T>(T symbol, int count) {
    List<T> arr = [];
    for (var i = 0; i < count; i++) {
      arr.add(symbol);
    }
    return arr;
  }
}
