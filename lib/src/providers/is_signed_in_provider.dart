import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_signed_in_provider.g.dart';

@riverpod
bool isSignedIn(IsSignedInRef ref) {
  final userId = ref.watch(userIdProvider);
  return userId != null;
}
