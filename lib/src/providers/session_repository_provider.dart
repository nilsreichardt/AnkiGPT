import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionRepositoryProvider = Provider((ref) {
  final functions = ref.watch(functionsProvider);
  return SessionRepository(functions: functions);
});
