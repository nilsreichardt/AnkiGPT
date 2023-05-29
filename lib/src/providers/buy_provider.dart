import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const routeFunctionsUrl = 'https://route-haaaagicoa-ew.a.run.app';

final buyProvider = FutureProvider((ref) {
  final cloudFunctions = ref.read(functionsProvider);
  return cloudFunctions.httpsCallableFromUrl(routeFunctionsUrl).call({
    'destination': 'analyticsBuy',
  });
});
