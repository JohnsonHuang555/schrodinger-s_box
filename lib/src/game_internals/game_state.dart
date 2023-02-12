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
    currentRisk = _getRandomNumber(3);
    currentSymbols = _getCurrentSymbols();
  }

  // 所有關卡的盒子
  List<MathSymbol> _getCurrentSymbols() {
    List<MathSymbol> symbols;
    switch (currentRisk) {
      case 1:
        symbols = GameRisk.risk1();
        break;
      case 2:
        symbols = GameRisk.risk2();
        break;
      case 3:
        symbols = GameRisk.risk3();
        break;
      default:
        symbols = GameRisk.risk1();
        break;
    }
    return _shuffleArray(symbols);
  }

  // 關卡提示內容物
  List<IconData> get symbolsHint {
    List<IconData> icons;
    switch (currentRisk) {
      case 1:
        icons = [Icons.add_circle, Icons.remove_circle];
        break;
      case 2:
        icons = [Icons.add_circle, Icons.remove_circle, Icons.question_mark];
        break;
      case 3:
        icons = [Icons.add_circle, Icons.remove_circle, Icons.question_mark];
        break;
      default:
        icons = [Icons.add_circle, Icons.remove_circle];
        break;
    }
    return icons;
  }

  /// 產生 1~max 的隨機亂數
  int _getRandomNumber(int max) {
    var random = Random();
    return random.nextInt(max) + 1;
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

  // 選擇符號
  void selectSymbol(int index, MathSymbol symbol) {
    var isExist = false;
    for (var element in selectedSymbols) {
      if (element.index == index) {
        isExist = true;
        break;
      }
    }

    if (selectedSymbols.isEmpty || !isExist) {
      selectedSymbols.add(SelectedSymbol(index, symbol));
      notifyListeners();
      return;
    }

    if (isExist) {
      selectedSymbols.removeWhere((element) => element.index == index);
    }

    notifyListeners();
  }
}
