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
  List<double> numbers = [];
  List<SelectedItem> selectedItems = [];

  int step = 1;

  GameState() {
    risk = _getRandomNumber(3);
    mathSymbols = _getCurrentSymbols();
    numbers = _getCurrentNumbers();
  }

  // 所有關卡符號的盒子
  List<MathSymbol> _getCurrentSymbols() {
    List<MathSymbol> symbols;
    switch (risk) {
      case 1:
        symbols = GameRisk.symbolRisk1();
        break;
      case 2:
        symbols = GameRisk.symbolRisk2();
        break;
      case 3:
        symbols = GameRisk.symbolRisk3();
        break;
      default:
        symbols = GameRisk.symbolRisk1();
        break;
    }
    return _shuffleArray(symbols);
  }

  // 所有關卡數字的盒子
  List<double> _getCurrentNumbers() {
    List<double> numbers;
    switch (risk) {
      case 1:
        numbers = GameRisk.numberRisk1();
        break;
      case 2:
        numbers = GameRisk.numberRisk2();
        break;
      case 3:
        numbers = GameRisk.numberRisk3();
        break;
      default:
        numbers = GameRisk.numberRisk1();
        break;
    }
    return _shuffleArray(numbers);
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
  List<IconData> get contentHint {
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
    if (selectedItems.isEmpty) {
      return;
    }
    step = step + 1;
    notifyListeners();
  }

  // 選擇盒子
  void selectItem({required int index, MathSymbol? symbol, double? number}) {
    var isExist = false;
    for (var element in selectedItems) {
      if (element.index == index) {
        isExist = true;
        break;
      }
    }

    if (selectedItems.isEmpty || !isExist) {
      // 最多選三個
      if (selectedItems.length == 3) {
        return;
      }

      if (step == 2) {
        // var currentSelectedSymbolCount = selectedItems.firstWhere((element) => element.symbol);
      }

      selectedItems.add(SelectedItem(
        index: index,
        symbol: symbol,
        number: number,
      ));
      notifyListeners();
      return;
    }

    if (isExist) {
      selectedItems.removeWhere((element) => element.index == index);
    }

    notifyListeners();
  }
}
