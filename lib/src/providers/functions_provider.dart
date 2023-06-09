import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'functions_provider.g.dart';

@riverpod
FirebaseFunctions cloudFunctions(CloudFunctionsRef ref) {
  return FirebaseFunctions.instanceFor(region: 'europe-west1');
}
