import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/deck_list_provider.dart';
import 'package:ankigpt/src/providers/user_id_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_session_docs_provider.g.dart';

@riverpod
Stream<List<SessionDto>> streamSessionDocs(
  StreamSessionDocsRef ref, {
  DateTime? lastCreatedAt,
}) {
  final firestore = ref.watch(cloudFirestoreProvider);
  final userId = ref.watch(userIdProvider);

  if (userId == null) {
    return Stream.value([]);
  }

  Query<SessionDto> query = firestore
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
      .limit(deckListBatchSize);

  if (lastCreatedAt != null) {
    // Converting to Timestamp as workaround for
    // https://github.com/firebase/flutterfire/issues/12102.
    query = query.startAfter([Timestamp.fromDate(lastCreatedAt)]);
  }

  return query
      .snapshots()
      .map((event) => event.docs.map((e) => e.data()).toList());
}
