import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id_provider.g.dart';

@riverpod
String? userId(UserIdRef ref) {
  final authUser = ref.watch(authUserProvider).value;
  return authUser?.uid;
}
