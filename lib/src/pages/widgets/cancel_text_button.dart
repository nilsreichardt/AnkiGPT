import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CancelTextButton extends StatelessWidget {
  const CancelTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.pop(),
      child: const Text('CANCEL'),
    );
  }
}
