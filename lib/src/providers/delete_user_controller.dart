import 'package:ankigpt/src/infrastructure/delete_user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_user_controller.g.dart';

@riverpod
class DeleteUserController extends _$DeleteUserController {
  @override
  void build() {
    return;
  }

  DeleteUserRepository get _repository =>
      ref.read(deleteUserRepositoryProvider);

  Future<void> scheduleDeleteUser() async {
    await _repository.scheduleDeleteUser();
  }

  Future<void> cancelDeleteUser() async {
    await _repository.cancelDeleteUser();
  }
}
