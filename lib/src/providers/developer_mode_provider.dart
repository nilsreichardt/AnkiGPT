import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'developer_mode_provider.g.dart';

@riverpod
class HasDeveloperMode extends _$HasDeveloperMode {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
