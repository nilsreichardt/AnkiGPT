import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  return UserRepository(firebaseAuth: firebaseAuth);
});
