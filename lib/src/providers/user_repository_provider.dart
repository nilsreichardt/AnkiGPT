import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/providers/firebase_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return UserRepository(firebaseAuth: firebaseAuth);
}
