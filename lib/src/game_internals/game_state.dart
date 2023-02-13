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
  int? risk;
  List<MathSymbol> mathSymbols = [];
  List<SelectedSymbol> selectedSymbols = [];

  int step = 1;

  GameState() {
    risk = _getRandomNumber(3);
    mathSymbols = _getCurrentSymbols();
  }

  // 所有關卡的盒子
  List<MathSymbol> _getCurrentSymbols() {
    List<MathSymbol> symbols;
    switch (risk) {
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

  String get currentStep {
    switch (step) {
      case 1:
        return '符號';
      case 2:
        return '數字';
      case 3:
        return '組合';
      default:
        return '';
    }
  }

  // 關卡提示內容物
  List<IconData> get symbolsHint {
    List<IconData> icons;
    switch (risk) {
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

  // 下一步
  void nextStep() {
    if (selectedSymbols.isEmpty) {
      return;
    }
    step = step + 1;
    notifyListeners();
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
      // 最多選三個
      if (selectedSymbols.length == 3) {
        return;
      }
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
