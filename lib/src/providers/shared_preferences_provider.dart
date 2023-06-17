import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
class SharedPreferencesAccesser extends _$SharedPreferencesAccesser {
  @override
  SharedPreferences? build() {
    SharedPreferences.getInstance().then((value) => state = value);
    return null;
  }
}
