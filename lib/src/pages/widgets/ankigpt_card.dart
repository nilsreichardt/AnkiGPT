import 'package:flutter/material.dart';

final defaultAnkiGptBorderRadius = BorderRadius.circular(15);

class AnkiGptCard extends StatelessWidget {
  const AnkiGptCard({
    super.key,
    this.color,
    this.padding = const EdgeInsets.fromLTRB(14, 6, 14, 16),
    required this.child,
  });

  final Color? color;
  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: defaultAnkiGptBorderRadius,
      color: (color ?? Theme.of(context).colorScheme.inversePrimary)
          .withOpacity(0.1),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
