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

  /// 產生數學符號 risk 1，5個加號、4個減號
  static List<MathSymbol> symbolRisk1() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 5);
    var minusSymbol = _createBoxes(MathSymbol.minus, 4);
    return [...plusSymbol, ...minusSymbol];
  }

  /// 產生數學符號 risk 2，3個加號、5個減號、1個乘號
  static List<MathSymbol> symbolRisk2() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 3);
    var minusSymbol = _createBoxes(MathSymbol.minus, 5);
    var timesSymbol = _createBoxes(MathSymbol.times, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol];
  }

  /// 產生數學符號 risk 3，3個加號、4個減號、1個乘號、1個除號
  static List<MathSymbol> symbolRisk3() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 3);
    var minusSymbol = _createBoxes(MathSymbol.minus, 4);
    var timesSymbol = _createBoxes(MathSymbol.times, 1);
    var divideSymbol = _createBoxes(MathSymbol.divide, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 4，2個加號、4個減號、2個乘號、1個除號
  static List<MathSymbol> symbolRisk4() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 2);
    var minusSymbol = _createBoxes(MathSymbol.minus, 4);
    var timesSymbol = _createBoxes(MathSymbol.times, 2);
    var divideSymbol = _createBoxes(MathSymbol.divide, 1);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 5，1個加號、2個減號、3個乘號、3個除號
  static List<MathSymbol> symbolRisk5() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 1);
    var minusSymbol = _createBoxes(MathSymbol.minus, 2);
    var timesSymbol = _createBoxes(MathSymbol.times, 3);
    var divideSymbol = _createBoxes(MathSymbol.divide, 3);
    return [...plusSymbol, ...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 6，2個加號、3個乘號、4個除號
  static List<MathSymbol> symbolRisk6() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 2);
    var timesSymbol = _createBoxes(MathSymbol.times, 3);
    var divideSymbol = _createBoxes(MathSymbol.divide, 4);
    return [...plusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 7，1個加號、4個乘號、4個除號
  static List<MathSymbol> symbolRisk7() {
    var plusSymbol = _createBoxes(MathSymbol.plus, 1);
    var timesSymbol = _createBoxes(MathSymbol.times, 4);
    var divideSymbol = _createBoxes(MathSymbol.divide, 4);
    return [...plusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 8，1個減號、4個乘號、4個除號
  static List<MathSymbol> symbolRisk8() {
    var minusSymbol = _createBoxes(MathSymbol.minus, 1);
    var timesSymbol = _createBoxes(MathSymbol.times, 4);
    var divideSymbol = _createBoxes(MathSymbol.divide, 4);
    return [...minusSymbol, ...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 9，5個乘號、4個除號
  static List<MathSymbol> symbolRisk9() {
    var timesSymbol = _createBoxes(MathSymbol.times, 5);
    var divideSymbol = _createBoxes(MathSymbol.divide, 4);
    return [...timesSymbol, ...divideSymbol];
  }

  /// 產生數學符號 risk 10，5個乘號、4個除號
  static List<MathSymbol> symbolRisk10() {
    var timesSymbol = _createBoxes(MathSymbol.times, 4);
    var divideSymbol = _createBoxes(MathSymbol.divide, 5);
    return [...timesSymbol, ...divideSymbol];
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
    var number1 = _createBoxes<double>(1, 2);
    var number2 = _createBoxes<double>(2, 2);
    var number5 = _createBoxes<double>(3, 3);
    var number8 = _createBoxes<double>(5, 2);
    return [...number1, ...number2, ...number5, ...number8];
  }

  /// 產生數學 risk 3
  static List<double> numberRisk3() {
    var number2 = _createBoxes<double>(2, 3);
    var number3 = _createBoxes<double>(3, 3);
    var number4 = _createBoxes<double>(4, 3);
    return [...number2, ...number3, ...number4];
  }

  /// 產生數學 risk 4
  static List<double> numberRisk4() {
    var number2 = _createBoxes<double>(2, 1);
    var number3 = _createBoxes<double>(3, 2);
    var number4 = _createBoxes<double>(4, 3);
    var number5 = _createBoxes<double>(5, 2);
    var number6 = _createBoxes<double>(6, 1);
    return [...number2, ...number3, ...number4, ...number5, ...number6];
  }

  /// 產生數學 risk 5
  static List<double> numberRisk5() {
    var number3 = _createBoxes<double>(3, 2);
    var number4 = _createBoxes<double>(4, 3);
    var number5 = _createBoxes<double>(5, 3);
    var number6 = _createBoxes<double>(6, 1);
    return [...number3, ...number4, ...number5, ...number6];
  }

  /// 產生數學 risk 6
  static List<double> numberRisk6() {
    var number3 = _createBoxes<double>(3, 1);
    var number4 = _createBoxes<double>(4, 3);
    var number5 = _createBoxes<double>(5, 3);
    var number6 = _createBoxes<double>(6, 1);
    var number7 = _createBoxes<double>(7, 1);
    return [...number3, ...number4, ...number5, ...number6, ...number7];
  }

  /// 產生數學 risk 7
  static List<double> numberRisk7() {
    var number4 = _createBoxes<double>(4, 2);
    var number5 = _createBoxes<double>(5, 3);
    var number6 = _createBoxes<double>(6, 2);
    var number7 = _createBoxes<double>(7, 1);
    var number8 = _createBoxes<double>(8, 1);
    return [...number4, ...number5, ...number6, ...number7, ...number8];
  }

  /// 產生數學 risk 8
  static List<double> numberRisk8() {
    var number5 = _createBoxes<double>(5, 3);
    var number6 = _createBoxes<double>(6, 2);
    var number7 = _createBoxes<double>(7, 2);
    var number8 = _createBoxes<double>(8, 2);
    return [...number5, ...number6, ...number7, ...number8];
  }

  /// 產生數學 risk 9
  static List<double> numberRisk9() {
    var number6 = _createBoxes<double>(6, 3);
    var number7 = _createBoxes<double>(7, 3);
    var number9 = _createBoxes<double>(9, 3);
    return [...number6, ...number7, ...number9];
  }

  /// 產生數學 risk 10
  static List<double> numberRisk10() {
    var number5 = _createBoxes<double>(5, 1);
    var number6 = _createBoxes<double>(6, 2);
    var number7 = _createBoxes<double>(7, 2);
    var number9 = _createBoxes<double>(9, 2);
    var number10 = _createBoxes<double>(10, 2);
    return [...number5, ...number6, ...number7, ...number9, ...number10];
  }

  static List<T> _createBoxes<T>(T content, int count) {
    List<T> arr = [];
    for (var i = 0; i < count; i++) {
      arr.add(content);
    }
    return arr;
  }
}
