import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wants_to_buy_provider.g.dart';

@Riverpod(keepAlive: true)
class WantsToBuy extends _$WantsToBuy {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
