import 'package:ankigpt/src/models/flavor.dart';
import 'package:ankigpt/src/providers/flavor_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_firestore_provider.g.dart';

@riverpod
FirebaseFirestore cloudFirestore(CloudFirestoreRef ref) =>
    FirebaseFirestore.instance;

@riverpod
String routeFunctionsUrl(RouteFunctionsUrlRef ref) {
  final flavor = ref.read(flavorProvider);
  switch (flavor) {
    case Flavor.prod:
      return 'https://route-haaaagicoa-ew.a.run.app';
    case Flavor.dev:
      return 'https://route-s4vv6oewqa-ew.a.run.app';
  }
}
