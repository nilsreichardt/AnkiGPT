import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_repository_provider.g.dart';

@riverpod
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  final functions = ref.watch(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  return SessionRepository(
    functions: functions,
    routeFunctionsUrl: routeUrl,
  );
}
