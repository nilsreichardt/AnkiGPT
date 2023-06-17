import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_searching_provider.g.dart';

@riverpod
class IsSearching extends _$IsSearching {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}
