import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:ankigpt/src/providers/firebase_auth_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@riverpod
Future<void> signIn(SignInRef ref, {required AuthProvider authProvider}) async {
  final auth = ref.read(firebaseAuthProvider);
  final user = ref.read(authUserProvider).value;
  final logger = ref.read(loggerProvider);

  if (user != null && !user.isAnonymous) {
    logger.d('User is already signed in with Google or Apple');
    return;
  }

  final userRepository = ref.read(userRepositoryProvider);
}
