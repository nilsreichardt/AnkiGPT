import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_successful_playment_dialog.g.dart';

@Riverpod(keepAlive: true)
class ShowSuccessfulPaymentDialog extends _$ShowSuccessfulPaymentDialog {
  bool _shouldShow = false;

  @override
  void build() {
    return;
  }

  void set(bool value) {
    _shouldShow = value;
  }

  bool get() {
    return _shouldShow;
  }
}
