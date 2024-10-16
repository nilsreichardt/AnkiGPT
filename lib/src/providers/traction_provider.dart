import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'traction_provider.g.dart';

/// Returns the total number of flashcards generated as formatted string.
///
/// Example: '1,234,567'
@Riverpod(keepAlive: true)
Stream<String> getTractionStream(GetTractionStreamRef ref) {
  final firestore = ref.read(cloudFirestoreProvider);
  return firestore.doc('Analytics/overview').snapshots().map((snapshot) {
    final traction = snapshot.data()!['totalCards'] as int;
    return formatTraction(traction);
  });
}

@visibleForTesting
String formatTraction(int traction) {
  return traction.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
}
