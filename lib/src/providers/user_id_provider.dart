import 'package:ankigpt/src/providers/firebase_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id_provider.g.dart';

@riverpod
String? userId(UserIdRef ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return auth.currentUser?.uid;
}
