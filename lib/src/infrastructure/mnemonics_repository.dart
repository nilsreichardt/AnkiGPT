import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:cloud_functions/cloud_functions.dart';

class MnemonicsRepository {
  final FirebaseFunctions cloudFunctions;
  final String routeUrl;

  MnemonicsRepository({
    required this.cloudFunctions,
    required this.routeUrl,
  });

  Future<String> generate({
    required CardId cardId,
    required SessionId sessionId,
    required String question,
    required String answer,
  }) async {
    final response = await cloudFunctions
        .httpsCallableFromUrl(routeUrl)
        .call<Map<String, dynamic>>({
      'destination': 'generateMnemonic',
      'payload': {
        'cardId': cardId,
        'sessionId': sessionId,
        'question': question,
        'answer': answer,
      }
    });

    return response.data['mnemonic'] as String;
  }

  Future<void> append({
    required String mnemonic,
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    await cloudFunctions.httpsCallableFromUrl(routeUrl).call({
      'destination': 'appendMnemonic',
      'payload': {
        'cardId': cardId,
        'sessionId': sessionId,
        'mnemonic': mnemonic,
      }
    });
  }
}
