import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock_shared_preferences_accesser.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
class MockSharedPreferencesAcccesser extends SharedPreferencesAccesser {
  final MockSharedPreferences? _sharedPreferences;

  MockSharedPreferencesAcccesser(this._sharedPreferences);

  @override
  SharedPreferences? build() {
    return _sharedPreferences;
  }
}
