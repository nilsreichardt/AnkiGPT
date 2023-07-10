import 'package:ankigpt/src/infrastructure/buy_repository.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_repostiroy_provider.dart.g.dart';

@riverpod
BuyRepository buyRepository(BuyRepositoryRef ref) {
  return BuyRepository(
    cloudFunctions: ref.read(cloudFunctionsProvider),
    routeUrl: ref.read(routeFunctionsUrlProvider),
  );
}
