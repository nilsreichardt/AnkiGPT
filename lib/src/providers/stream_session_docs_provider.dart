import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_session_docs_provider.g.dart';

@riverpod
Stream<List<SessionDto>> streamSessionDocs(StreamSessionDocsRef ref) {
  final firestore = ref.watch(cloudFirestoreProvider);
  final userId = ref.watch(userIdProvider);

  if (userId == null) {
    return Stream.value([]);
  }

  return firestore
      .collection('Sessions')
      .withConverter(
        fromFirestore: (doc, options) => SessionDto.fromJsonWithInjectedId(
          doc.id,
          doc.data()!,
        ),
        toFirestore: (_, __) => throw UnimplementedError(),
      )
      .where(
        'userId',
        isEqualTo: userId,
      )
      .orderBy('createdAt', descending: true)
      .limit(10)
      .snapshots()
      .map((event) => event.docs.map((e) => e.data()).toList());
}
