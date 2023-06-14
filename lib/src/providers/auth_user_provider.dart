import 'package:ankigpt/src/providers/firebase_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_user_provider.g.dart';

@riverpod
Stream<User?> authUser(AuthUserRef ref) {
  return ref.watch(firebaseAuthProvider).userChanges();
}
