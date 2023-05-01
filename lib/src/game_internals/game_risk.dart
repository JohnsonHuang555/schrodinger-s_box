import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './game_state.dart';

class GameRisk {
  static IconData? convertSymbolToIcon(MathSymbol symbol) {
    switch (symbol) {
      case MathSymbol.plus:
        return FontAwesomeIcons.plus;
      case MathSymbol.minus:
        return FontAwesomeIcons.minus;
      case MathSymbol.times:
        return FontAwesomeIcons.xmark;
      case MathSymbol.divide:
        return FontAwesomeIcons.divide;
      default:
        return null;
    }
  }

  static bool isInteger(double value) => value == value.toInt();

  /// 產生數學符號 risk 1
  static List<MathSymbol> symbolRisk1() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 5);
    var minusSymbol = _createBoxes(MathSymbol.minus, 4);
    return [...plusSymbol, ...minusSymbol];
  }

  /// 產生數學符號 risk 2
  static List<MathSymbol> symbolRisk2() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 3);
    var minusSymbol = _createBoxes(MathSymbol.minus, 5);
    var timesSymbol = _createBoxes(MathSymbol.times, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol];
  }

  /// 產生數學符號 risk 3
  static List<MathSymbol> symbolRisk3() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 3);
    var minusSymbol = _createBoxes(MathSymbol.minus, 4);
    var timesSymbol = _createBoxes(MathSymbol.times, 1);
    var divideSymbol = _createBoxes(MathSymbol.divide, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  // ------------------------------------------------------------------------ //

  /// 產生數學 risk 1
  static List<double> numberRisk1() {
    var number1 = _createBoxes<double>(1, 3);
    var number2 = _createBoxes<double>(2, 3);
    var number3 = _createBoxes<double>(3, 2);
    var number5 = _createBoxes<double>(5, 1);
    return [...number1, ...number2, ...number3, ...number5];
  }

  /// 產生數學 risk 2
  static List<double> numberRisk2() {
    var numberN1 = _createBoxes<double>(-1, 2);
    var number3 = _createBoxes<double>(3, 2);
    var number5 = _createBoxes<double>(5, 3);
    var number8 = _createBoxes<double>(8, 2);
    return [...numberN1, ...number3, ...number5, ...number8];
  }

  /// 產生數學 risk 3
  static List<double> numberRisk3() {
    var numberN5 = _createBoxes<double>(-5, 1);
    var numberN1 = _createBoxes<double>(-1, 2);
    var number5 = _createBoxes<double>(5, 3);
    var number8 = _createBoxes<double>(8, 2);
    var number10 = _createBoxes<double>(10, 1);
    return [...numberN5, ...numberN1, ...number5, ...number8, ...number10];
  }

  static List<T> _createBoxes<T>(T content, int count) {
    List<T> arr = [];
    for (var i = 0; i < count; i++) {
      arr.add(content);
    }
    return arr;
  }
}
