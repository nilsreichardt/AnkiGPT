import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/providers/auth_user_provider.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/router_provider.dart';
import 'package:ankigpt/src/providers/stripe_checkout_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:ankigpt/src/providers/wants_to_buy_provider.dart';
import 'package:ankigpt/src/providers/wants_to_generate_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_provider.g.dart';

@Riverpod(dependencies: [GenerateNotifier])
Future<void> signIn(SignInRef ref, {required AuthProvider authProvider}) async {
  final user = ref.read(authUserProvider).value;
  final logger = ref.read(loggerProvider);

  try {
    if (user != null && !user.isAnonymous) {
      logger.d('User is already signed in with Google or Apple');
      return;
    }

    await _makeSignIn(ref, authProvider: authProvider, user: user);

    final wantToBuyPlus = ref.read(wantsToBuyProvider);
    if (wantToBuyPlus) {
      await ref.read(stripeCheckoutProvider.notifier).open();
    }

    final wantsToGenerate = ref.read(wantsToGenerateProvider);
    if (wantsToGenerate) {
      ref.read(generateNotifierProvider.notifier).submit();
      ref.read(routerProvider).go('/');
    }
  } catch (e, s) {
    logger.e('Error while signing in with ${authProvider.name}', e, s);
    rethrow;
  }
}

Future<void> _makeSignIn(
  SignInRef ref, {
  required AuthProvider authProvider,
  required User? user,
}) async {
  final logger = ref.read(loggerProvider);
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
}
