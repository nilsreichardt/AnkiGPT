import 'package:flutter/material.dart';

extension SnackBarExtension on BuildContext {
  /// Shows a snackbar with a [text] as content.
  void showTextSnackBar(
    String text, {
    SnackBarAction? action,
    bool withLoadingCircle = false,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (withLoadingCircle)
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 4),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Theme.of(this).colorScheme.inversePrimary,
                  ),
                ),
              ),
            Flexible(child: Text(text)),
          ],
        ),
        // We set the width so that the snackbar does not take the full width of
        // the screen.
        //
        // Devices with exactly 400 pixels would have a snackbar with no margin.
        // Therefore, we we set the width only form devices with with > 420.
        width: MediaQuery.of(this).size.width < 420 ? null : 400,
        action: action,
        duration: duration ?? Duration(seconds: withLoadingCircle ? 60 : 4),
      ),
    );
  }

  /// Removes the current [SnackBar] by running its normal exit animation.
  ///
  /// The closed completer is called after the animation is complete.
  void hideSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}

extension DimensionsExtension on BuildContext {
  bool get isTiny => MediaQuery.of(this).size.width < 350;
  bool get isMobile => MediaQuery.of(this).size.width < 650;
  bool get isTablet => MediaQuery.of(this).size.width >= 650;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1000;
}
