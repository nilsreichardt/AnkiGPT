import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_user_repository.g.dart';

@riverpod
DeleteUserRepository deleteUserRepository(DeleteUserRepositoryRef ref) {
  final cloudFunctions = ref.watch(cloudFunctionsProvider);
  final routeFunctionsUrl = ref.read(routeFunctionsUrlProvider);
  return DeleteUserRepository(cloudFunctions, routeFunctionsUrl);
}

class DeleteUserRepository {
  const DeleteUserRepository(
    this._functions,
    this._routeFunctionsUrl,
  );

  final FirebaseFunctions _functions;
  final String _routeFunctionsUrl;

  Future<void> scheduleDeleteUser() async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'scheduleAccountDeletion',
    });
  }

  Future<void> cancelDeleteUser() async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'cancelScheduledAccountDeletion',
    });
  }
}
