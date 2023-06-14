import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@riverpod
Future<void> signIn(SignInRef ref, {required AuthProvider authProvider}) async {
  final user = ref.read(authUserProvider).value;
  final logger = ref.read(loggerProvider);

  if (user != null && !user.isAnonymous) {
    logger.d('User is already signed in with Google or Apple');
    return;
  }

  final userRepository = ref.read(userRepositoryProvider);
  final isSignedIn = user != null;
  if (!isSignedIn) {
    logger.d('User is not signed in. Signing in with ${authProvider.name}');
    await userRepository.signInWith(authProvider);
    return;
  }

  logger.d(
      'User is already signed in with Anonymous. Try to link this account with ${authProvider.name}');
  try {
    await userRepository.linkWith(authProvider);
  } on ProviderAlreadyInUse catch (_) {
    logger.d(
        'Provider is already in use. No need, to link the current account. Signing out and signing in again');
    await userRepository.signOut();
    await userRepository.signInWith(authProvider);
  }

  logger.d('User is not signed in. Signing in with ${authProvider.name}');
}
