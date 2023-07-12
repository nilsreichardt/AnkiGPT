import 'package:flutter/material.dart';

class PlusBadge extends StatelessWidget {
  const PlusBadge({
    super.key,
    this.withText = true,
  });

  final bool withText;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 100,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 14,
              ),
              if (withText) ...[
                const SizedBox(width: 6),
                const Text(
                  'PLUS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
