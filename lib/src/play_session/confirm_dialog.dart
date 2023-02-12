import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('提示'),
      content: const Text('確定要選擇這些 ?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, '取消'),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, '確定'),
          child: const Text('確定'),
        ),
      ],
    );
  }
}
