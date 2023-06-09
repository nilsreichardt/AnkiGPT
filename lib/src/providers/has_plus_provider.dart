import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_plus_provider.g.dart';

@riverpod
class HasPlus extends _$HasPlus {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
