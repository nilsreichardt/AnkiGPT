import 'package:ankigpt/src/infrastructure/mnemonics_repository.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mnemonics_repository_provider.g.dart';

@riverpod
MnemonicsRepository mnemonicsRepository(MnemonicsRepositoryRef ref) {
  final functions = ref.watch(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  return MnemonicsRepository(
    cloudFunctions: functions,
    routeUrl: routeUrl,
  );
}
