import 'package:ankigpt/src/infrastructure/delete_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_user_provider.g.dart';

@riverpod
Future<void> scheduleDeleteUser(ScheduleDeleteUserRef ref) async {
  final repository = ref.read(deleteUserRepositoryProvider);
  await repository.scheduleDeleteUser();
}

@riverpod
Future<void> cancelDeleteUser(CancelDeleteUserRef ref) async {
  final repository = ref.read(deleteUserRepositoryProvider);
  await repository.cancelDeleteUser();
}
