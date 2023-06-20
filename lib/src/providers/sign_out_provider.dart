import 'package:ankigpt/src/providers/clear_session_state_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_provider.g.dart';

@riverpod
Future<void> signOut(SignOutRef ref) async {
  ref.read(clearSessionStateProvider.notifier).clear();
  await ref.read(userRepositoryProvider).signOut();
}
