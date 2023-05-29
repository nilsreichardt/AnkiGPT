import 'dart:convert';

import 'package:ankigpt/src/models/get_cards_response.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/buy_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SessionRepository {
  final FirebaseFunctions functions;

  const SessionRepository({required this.functions});

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

  Future<GetCardsResponse> getCards({
    required SessionId sessionId,
  }) async {
    final result = await functions
        .httpsCallableFromUrl(routeFunctionsUrl)
        .call<Map<String, dynamic>>({
      'destination': 'getCards',
      'payload': {
        'sessionId': sessionId,
      }
    });
    return GetCardsResponse.fromJson(jsonDecode(jsonEncode(result.data)));
  }
}
