import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_editing_card_loading.g.dart';

@Riverpod(keepAlive: true)
class IsEditingCardLoading extends _$IsEditingCardLoading {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}
