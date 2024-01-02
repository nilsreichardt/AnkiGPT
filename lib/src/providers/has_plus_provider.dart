import 'package:ankigpt/src/providers/app_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_plus_provider.g.dart';

@Riverpod(dependencies: [], keepAlive: true)
bool hasPlus(HasPlusRef ref) {
  final appUser = ref.watch(appUserProvider);
  return appUser.value?.hasPlus ?? false;
}
