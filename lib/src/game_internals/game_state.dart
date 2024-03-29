import 'dart:math';

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

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
  // 顯示選完的結果
  bool showChooseResult = false;
  List<SelectedItem> currentFormulaItems = [];

  int step = 1;

  GameState() {
    risk = _getRandomNumber(10);
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
      case 4:
        symbols = GameRisk.symbolRisk4();
        break;
      case 5:
        symbols = GameRisk.symbolRisk5();
        break;
      case 6:
        symbols = GameRisk.symbolRisk6();
        break;
      case 7:
        symbols = GameRisk.symbolRisk7();
        break;
      case 8:
        symbols = GameRisk.symbolRisk8();
        break;
      case 9:
        symbols = GameRisk.symbolRisk9();
        break;
      case 10:
        symbols = GameRisk.symbolRisk10();
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
      case 4:
        numbers = GameRisk.numberRisk4();
        break;
      case 5:
        numbers = GameRisk.numberRisk5();
        break;
      case 6:
        numbers = GameRisk.numberRisk6();
        break;
      case 7:
        numbers = GameRisk.numberRisk7();
        break;
      case 8:
        numbers = GameRisk.numberRisk8();
        break;
      case 9:
        numbers = GameRisk.numberRisk9();
        break;
      case 10:
        numbers = GameRisk.numberRisk10();
        break;
      default:
        numbers = GameRisk.numberRisk1();
        break;
    }
    return _shuffleArray(numbers);
  }

  // 關卡提示內容物
  List<IconData> get hint {
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

  String getCurrentAnswer(String currentScore) {
    String result = currentScore;

    if (currentFormulaItems.isEmpty) {
      return '?';
    }

    // 第一個一定要放符號
    if (currentFormulaItems[0].symbol == null) {
      return 'x';
    }

    for (var i = 0; i < currentFormulaItems.length; i++) {
      // 符號
      if (currentFormulaItems[i].symbol != null) {
        switch (currentFormulaItems[i].symbol) {
          case MathSymbol.plus:
            result += '+';
            break;
          case MathSymbol.minus:
            result += '-';
            break;
          case MathSymbol.times:
            result += '*';
            break;
          case MathSymbol.divide:
            result += '/';
            break;
          default:
            break;
        }
      }
      // 數字
      else if (currentFormulaItems[i].number != null) {
        var resultNumber = '';
        if (GameRisk.isInteger(currentFormulaItems[i].number!)) {
          resultNumber = currentFormulaItems[i].number!.toInt().toString();
        } else {
          if (currentFormulaItems[i].number! < 0) {
            resultNumber = '(${currentFormulaItems[i].number!.toString()})';
          } else {
            resultNumber = currentFormulaItems[i].number!.toString();
          }
        }
        result += resultNumber;
      }
    }

    try {
      var answer = result.interpret();
      print(result);
      return answer.toInt().toString();
    } catch (e) {
      return '?';
    }
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

    showChooseResult = true;
    Future.delayed(Duration(milliseconds: 2000), () {
      showChooseResult = false;
      step = step + 1;
      notifyListeners();
    });
    notifyListeners();
  }

  // 選擇盒子
  void selectItem({required int index, MathSymbol? symbol, double? number}) {
    if (step == 1) {
      var isExist = false;
      for (var element in selectedItems) {
        if (element.index == index && element.symbol != null) {
          isExist = true;
          break;
        }
      }

      // 第一階段最多選三個
      if (!isExist && selectedItems.length != 3) {
        selectedItems.add(SelectedItem(
          index: index,
          symbol: symbol,
        ));
      }
      if (isExist) {
        selectedItems.removeWhere(
            (element) => element.index == index && element.symbol != null);
      }
    } else {
      var isExist = false;
      for (var element in selectedItems) {
        if (element.index == index && element.number != null) {
          isExist = true;
          break;
        }
      }

      // 已選擇的數字
      var currentSelectedNumber =
          selectedItems.where((element) => element.number != null).length + 1;

      // 第二階段依照第一階段選幾個就要選幾個
      if (!isExist && currentSelectedNumber <= 3) {
        selectedItems.add(SelectedItem(
          index: index,
          number: number,
        ));
      }
      if (isExist) {
        selectedItems.removeWhere(
            (element) => element.index == index && element.number != null);
      }
    }
    notifyListeners();
  }

  void selectAnswer(SelectedItem item) {
    var alreadySelected = currentFormulaItems.singleWhere(
        (e) => e.id == item.id,
        orElse: () => SelectedItem(index: -1, id: ''));

    if (alreadySelected.id == '') {
      currentFormulaItems.add(item);
    } else {
      currentFormulaItems.removeWhere((element) => element.id == item.id);
    }
    notifyListeners();
  }

  void clearAnswer() {
    currentFormulaItems.clear();
    notifyListeners();
  }
}
