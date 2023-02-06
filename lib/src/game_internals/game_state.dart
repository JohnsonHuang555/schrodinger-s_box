import 'dart:math';
import 'package:flutter/material.dart';
import './game_risk.dart';

enum MathSymbol {
  plus,
  minus,
  times,
  divide,
}

class GameState extends ChangeNotifier {
  int? currentRisk;
  List<MathSymbol> currentSymbols = [];

  GameState() {
    currentRisk = _getRandomNumber(10);
    currentSymbols = GameRisk().risk1();
  }

  /// 產生 1~max 的隨機亂數
  int _getRandomNumber(int max) {
    var random = Random();
    return random.nextInt(max) + 1;
  }

  void selectSymbol(MathSymbol symbol) {
    print(symbol);
  }
}
