import 'package:flutter/material.dart';

class ScanResultDialog extends StatelessWidget {

  const ScanResultDialog({
    super.key,
    required this.onScanPressed,
    required this.onCheckPressed,
  });
  final VoidCallback onScanPressed;
  final VoidCallback onCheckPressed;

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

  static show({
    required BuildContext context,
    required VoidCallback onScanPressed,
    required VoidCallback onCheckPressed,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScanResultDialog(
          onScanPressed: onScanPressed,
          onCheckPressed: onCheckPressed,
        );
      },
    );
  }
}
