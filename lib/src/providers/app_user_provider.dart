import 'package:ankigpt/src/models/app_user.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_user_provider.g.dart';

@riverpod
Stream<AppUser?> appUser(AppUserRef ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return const Stream.empty();

  final firestore = ref.watch(cloudFirestoreProvider);
  return firestore.doc('Users/$userId').snapshots().map((snapshot) {
    if (!snapshot.exists) return null;
    return AppUser.fromJson(snapshot.data()!);
  });
}
