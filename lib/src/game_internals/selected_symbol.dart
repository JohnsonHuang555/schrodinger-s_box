import './game_state.dart';

class SelectedItem {
  int index;
  MathSymbol? symbol;
  double? number;

  SelectedItem({
    required this.index,
    this.symbol,
    this.number,
  });
}
