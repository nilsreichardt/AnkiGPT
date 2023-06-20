import 'dart:math';

import 'package:flutter/material.dart';

final defaultAnkiGptBorderRadius = BorderRadius.circular(15);

class AnkiGptCard extends StatefulWidget {
  const AnkiGptCard({
    super.key,
    this.color,
    this.padding = const EdgeInsets.fromLTRB(14, 6, 14, 16),
    required this.child,
    this.hoverColor,
    this.borderRadius,
  });

  final Color? color;
  final Color? hoverColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  /// The border radius of the card.
  ///
  /// Defaults to [defaultAnkiGptBorderRadius].
  final BorderRadiusGeometry? borderRadius;

  @override
  State<AnkiGptCard> createState() => _AnkiGptCardState();
}

class _AnkiGptCardState extends State<AnkiGptCard> {
  int randomInt = 0;

  Color? _getColor(BuildContext context) {
    if (widget.color == null) {
      return Theme.of(context).colorScheme.inversePrimary.withOpacity(0.1);
    }

    if (widget.color == Colors.transparent) {
      return widget.color;
    }

    return widget.color!.withOpacity(0.1);
  }

  @override
  void didUpdateWidget(AnkiGptCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.color != widget.color) {
      randomInt = Random().nextInt(1000000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      // Setting the curve interval the end to 0.5 to avoid showing nothing for a short period of time.
      switchInCurve: const Interval(
        0.0,
        0.5,
        curve: Curves.linear,
      ),
      switchOutCurve: const Interval(
        0.0,
        0.5,
        curve: Curves.linear,
      ),
      duration: const Duration(milliseconds: 275),
      child: Material(
        key: ValueKey(randomInt),
        borderRadius: widget.borderRadius ?? defaultAnkiGptBorderRadius,
        color: _getColor(context),
        child: Padding(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}
