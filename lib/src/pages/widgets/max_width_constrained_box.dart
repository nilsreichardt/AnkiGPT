import 'package:flutter/material.dart';

class MaxWidthConstrainedBox extends StatelessWidget {
  const MaxWidthConstrainedBox({
    super.key,
    required this.child,
    this.maxWidth = 1200,
  });

  final Widget child;

  /// The maximum width that satisfies the constraints.
  ///
  /// Default is 1000
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
