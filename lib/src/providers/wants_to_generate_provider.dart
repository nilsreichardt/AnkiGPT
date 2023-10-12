import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wants_to_generate_provider.g.dart';

@Riverpod(keepAlive: true)
class WantsToGenerate extends _$WantsToGenerate {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}
