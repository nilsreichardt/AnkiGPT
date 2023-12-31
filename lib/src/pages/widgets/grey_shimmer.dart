import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GreyShimmer extends StatelessWidget {
  const GreyShimmer({
    super.key,
    required this.child,
    required this.enabled,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: enabled
          ? Shimmer.fromColors(
              baseColor: Colors.grey[600]!,
              highlightColor: Colors.grey[300]!,
              child: child,
            )
          : child,
    );
  }
}
