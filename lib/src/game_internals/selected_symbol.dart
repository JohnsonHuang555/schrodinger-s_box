import './game_state.dart';

class SelectedItem {
  int index;
  MathSymbol? symbol;
  double? number;
  String? id;

  SelectedItem({
    required this.index,
    this.symbol,
    this.number,
    this.id,
  });
}
