import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_search_loading_provider.g.dart';

@riverpod
class IsSearchLoading extends _$IsSearchLoading {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}
