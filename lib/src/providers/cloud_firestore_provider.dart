import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_firestore_provider.g.dart';

@riverpod
FirebaseFirestore cloudFirestore(CloudFirestoreRef ref) =>
    FirebaseFirestore.instance;
