import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_warning_card.g.dart';

@riverpod
class ShowWarningCard extends _$ShowWarningCard {
  @override
  bool build() {
    final cache = ref.watch(sharedPreferencesAccesserProvider);
    return cache?.getBool('showWarningCard') ?? true;
  }

  void hide() {
    state = false;

    final cache = ref.watch(sharedPreferencesAccesserProvider);
    cache?.setBool('showWarningCard', false);
  }
}
