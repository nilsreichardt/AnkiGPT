import 'package:ankigpt/src/models/get_cards_response.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SessionRepository {
  final FirebaseFunctions functions;

  const SessionRepository({required this.functions});

  Future<SessionId> startSession({
    required String slideContent,
    required int numberOfCards,
  }) async {
    final result = await functions
        .httpsCallable('startSession')
        .call<Map<String, dynamic>>({
      'slideContent': slideContent,
      'numberOfCards': numberOfCards,
    });
    return result.data['sessionId'];
  }

  Future<GetCardsResponse> getCards({
    required SessionId sessionId,
  }) async {
    final result =
        await functions.httpsCallable('getCards').call<Map<String, dynamic>>({
      'sessionId': sessionId,
    });
    return GetCardsResponse.fromJson(result.data);
  }
}
