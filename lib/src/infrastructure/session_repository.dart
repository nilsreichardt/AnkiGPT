import 'dart:typed_data';

import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cross_file/cross_file.dart';

class SessionRepository {
  final FirebaseFunctions functions;
  final String routeFunctionsUrl;
  final FirebaseStorage storage;

  const SessionRepository({
    required this.functions,
    required this.routeFunctionsUrl,
    required this.storage,
  });

  Future<SessionId> startSession({
    required String? slideContent,
    required InputType type,
    required int numberOfCards,
    required SessionId? sessionId,
  }) async {
    final result = await functions
        .httpsCallableFromUrl(routeFunctionsUrl)
        .call<Map<String, dynamic>>({
      'destination': 'startSession',
      'payload': {
        'input': {
          'text': slideContent,
          'type': type.name,
        },
        'sessionId': sessionId,
        'numberOfCards': '$numberOfCards',
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
}
