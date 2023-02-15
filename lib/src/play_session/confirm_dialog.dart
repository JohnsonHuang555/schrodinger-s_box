import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const ConfirmDialog({
    super.key,
    required this.onConfirm,
  });

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
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('確定'),
        ),
      ],
    );
  }
}
