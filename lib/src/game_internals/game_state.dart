import 'dart:math';

import 'package:flutter/material.dart';

import './game_risk.dart';
import './selected_symbol.dart';

enum MathSymbol {
  plus,
  minus,
  times,
  divide,
}

class GameState extends ChangeNotifier {
  int? currentRisk;
  List<MathSymbol> currentSymbols = [];
  List<SelectedSymbol> selectedSymbols = [];

  GameState() {
    var risk = _getRandomNumber(3);
    currentRisk = risk;

    var symbols = _getSymbolsByRisk(risk);
    currentSymbols = _shuffleArray(symbols);
  }

  /// 產生 1~max 的隨機亂數
  int _getRandomNumber(int max) {
    var random = Random();
    return random.nextInt(max) + 1;
  }

  List<MathSymbol> _getSymbolsByRisk(int? risk) {
    switch (risk) {
      case 1:
        return GameRisk().risk1();
      case 2:
        return GameRisk().risk2();
      case 3:
        return GameRisk().risk3();
      default:
        return GameRisk().risk1();
    }
  }

  /// 隨機洗牌
  List<T> _shuffleArray<T>(List<T> array) {
    var random = Random();
    for (var i = array.length - 1; i > 0; i--) {
      var j = random.nextInt(i + 1);
      var temp = array[i];
      array[i] = array[j];
      array[j] = temp;
    }

    return array;
  }

  void selectSymbol(int index, MathSymbol symbol) {
    print(index);
    print(symbol);
    selectedSymbols.add(SelectedSymbol(index, symbol));
  }
}
