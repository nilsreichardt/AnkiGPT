import 'package:flutter/material.dart';

/// A widget that shows either a [Text] or a [CircularProgressIndicator] without
/// changing the size of the widget.
class TextOrCircularProgressIndicator extends StatelessWidget {
  const TextOrCircularProgressIndicator({
    super.key,
    required this.isUpdating,
    required this.child,
  });

  final bool isUpdating;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 275),
      child: Stack(
        key: ValueKey(isUpdating),
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isUpdating ? 0 : 1,
            child: child,
          ),
          if (isUpdating)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
        ],
      ),
    );
  }
}
