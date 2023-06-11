import 'package:ankigpt/src/models/session_id.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SessionRepository {
  final FirebaseFunctions functions;
  final String routeFunctionsUrl;

  const SessionRepository({
    required this.functions,
    required this.routeFunctionsUrl,
  });

  Future<SessionId> startSession({
    required String slideContent,
    required int numberOfCards,
  }) async {
    final result = await functions
        .httpsCallableFromUrl(routeFunctionsUrl)
        .call<Map<String, dynamic>>({
      'destination': 'startSession',
      'payload': {
        'slideContent': slideContent,
        'numberOfCards': '$numberOfCards',
      }
    });
    return result.data['id'];
  }
}
