import 'package:ankigpt/src/providers/firebase_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_account_provider.g.dart';

@riverpod
Stream<bool> hasAccount(HasAccountRef ref) {
  return ref
      .read(firebaseAuthProvider)
      .userChanges()
      .map((user) => user != null && !user.isAnonymous);
}
