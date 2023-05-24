import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final functionsProvider = Provider((ref) {
  return FirebaseFunctions.instanceFor(region: 'europe-west1');
});
