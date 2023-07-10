import 'package:ankigpt/src/pages/widgets/extensions.dart';
import 'package:flutter/material.dart';

void scrollTo({
  required BuildContext context,
  required GlobalKey key,
}) {
  if (key.currentContext != null) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutQuart,
    );
  } else {
    context.showTextSnackBar('Can not scroll.');
  }
}
