import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_provider.g.dart';

@riverpod
Future<void> buy(BuyRef ref) async {
  final cloudFunctions = ref.read(cloudFunctionsProvider);
  final routeUrl = ref.read(routeFunctionsUrlProvider);
  if (!kDebugMode) {
    await cloudFunctions.httpsCallableFromUrl(routeUrl).call({
      'destination': 'analyticsBuy',
    });
  }

  final userId = ref.read(userIdProvider);
  if (userId == null) {
    throw const UnauthenticatedException();
  }

  final cloudFirestore = ref.read(cloudFirestoreProvider);
  await cloudFirestore
      .collection('customers')
      .doc(userId)
      .collection('checkout_sessions')
      .doc()
      .set({
    'mode': 'payment',
    'price': 'price_1NJ0vbBWpb6oLyvXoE4QUewc',
    'success_url': 'https://ankigpt.wtf/success',
    'cancel_url': 'https://ankigpt.wtf/cancel_url',
  });
}

class UnauthenticatedException implements Exception {
  const UnauthenticatedException();
}
