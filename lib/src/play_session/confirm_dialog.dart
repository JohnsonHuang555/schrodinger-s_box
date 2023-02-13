import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../game_internals/game_state.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('提示'),
      content: const Text('確定要選擇這些 ?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, '取消'),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<GameState>(context, listen: false).nextStep();
          },
          child: const Text('確定'),
        ),
      ],
    );
  }
}
