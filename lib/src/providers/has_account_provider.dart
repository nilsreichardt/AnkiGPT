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

/// Returns true if the user is logged in and not anonymous.
@riverpod
bool hasAccount2(HasAccount2Ref ref) {
  final user = ref.read(firebaseAuthProvider).currentUser;
  return user != null && !user.isAnonymous;
}
