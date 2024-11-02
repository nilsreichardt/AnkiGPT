import 'dart:typed_data';

import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SessionRepository {
  final FirebaseFunctions functions;
  final String routeFunctionsUrl;
  final FirebaseStorage storage;
  final FirebaseFirestore firestore;

  const SessionRepository({
    required this.functions,
    required this.routeFunctionsUrl,
    required this.storage,
    required this.firestore,
  });

  Future<SessionId> startSession({
    required Input input,
    required int numberOfCards,
    required String model,
    required SessionId? sessionId,
    required Language language,
  }) async {
    final result = await functions
        .httpsCallable('startSession')
        .call<Map<String, dynamic>>({
      'payload': {
        'input': input.toJson(),
        'sessionId': sessionId,
        'numberOfCards': numberOfCards,
        'model': model,
        // Only include language when not auto-detecting to let the backend
        // handle detection.
        if (language != Language.auto) 'language': language.name,
      }
    });
    return result.data['id'];
  }

  Future<void> uploadFile({
    required SessionId sessionId,
    required UserId userId,
    required PlatformFile file,
  }) async {
    // Reading bytes could lead to UI freeze, however, this is macOS only and since we web-only, it's fine.
    Uint8List? bytes = file.bytes ?? await XFile(file.path!).readAsBytes();
    await storage.ref('sessions/$sessionId/input_file').putData(
          bytes,
          SettableMetadata(contentType: 'application/pdf', customMetadata: {
            'userId': userId,
          }),
        );
  }

  Future<void> deleteCard({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    await functions.httpsCallableFromUrl(routeFunctionsUrl).call({
      'destination': 'deleteCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
      }
    });
  }

  Future<void> undoDeleteCard({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    await functions
        .httpsCallableFromUrl(routeFunctionsUrl)
        .call<Map<String, dynamic>>({
      'destination': 'undoDeleteCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
      }
    });
  }

  Future<void> editAnswer({
    required SessionId sessionId,
    required CardId cardId,
    required String answer,
  }) async {
    await functions.httpsCallableFromUrl(routeFunctionsUrl).call({
      'destination': 'editAnswer',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
        'answer': answer,
      }
    });
  }

  Future<void> editQuestion({
    required SessionId sessionId,
    required CardId cardId,
    required String question,
  }) async {
    await functions.httpsCallableFromUrl(routeFunctionsUrl).call({
      'destination': 'editQuestion',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
        'question': question,
      }
    });
  }

  Stream<SessionDto?> streamSession(SessionId sessionId) {
    return firestore
        .collection('Sessions')
        .doc(sessionId)
        .withConverter(
          fromFirestore: (doc, options) =>
              SessionDto.fromJsonWithInjectedId(sessionId, doc.data()!),
          toFirestore: (_, __) => throw UnimplementedError(),
        )
        .snapshots()
        .map((event) => event.data());
  }

  Future<SessionDto?> getSession(SessionId sessionId) async {
    final doc = await firestore
        .collection('Sessions')
        .doc(sessionId)
        .withConverter(
          fromFirestore: (doc, options) =>
              SessionDto.fromJsonWithInjectedId(sessionId, doc.data()!),
          toFirestore: (_, __) => throw UnimplementedError(),
        )
        .get();
    return doc.data();
  }

  Future<void> setVisibility(
    SessionId sessionId,
    Visibility visibility,
  ) async {
    await functions.httpsCallableFromUrl(routeFunctionsUrl).call({
      'destination': 'setVisibility',
      'payload': {
        'sessionId': sessionId,
        'visibility': visibility.name,
      }
    });
  }

  Future<void> renameDeck({
    required SessionId sessionId,
    required String title,
  }) async {
    await functions.httpsCallableFromUrl(routeFunctionsUrl).call({
      'destination': 'renameDeck',
      'payload': {
        'sessionId': sessionId,
        'title': title,
      }
    });
  }

  Future<SessionId> importFromGpt({
    required List<Map<String, String>> cards,
  }) async {
    final res = await functions
        .httpsCallableFromUrl(routeFunctionsUrl)
        .call<Map<String, dynamic>>({
      'destination': 'importFromGpt',
      'payload': {
        'cards': cards,
      }
    });
    return res.data['sessionId'];
  }
}
