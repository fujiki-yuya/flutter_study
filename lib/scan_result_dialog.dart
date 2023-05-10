import 'package:flutter/material.dart';

class ScanResultDialog extends StatelessWidget {
  final VoidCallback onScanPressed;
  final VoidCallback onCheckPressed;

  const ScanResultDialog({
    Key? key,
    required this.onScanPressed,
    required this.onCheckPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('バーコードを読み取りました'),
      actions: [
        TextButton(
          onPressed: onScanPressed,
          child: const Text('スキャン'),
        ),
        TextButton(
          onPressed: onCheckPressed,
          child: const Text('商品確認'),
        )
      ],
    );
  }
}
