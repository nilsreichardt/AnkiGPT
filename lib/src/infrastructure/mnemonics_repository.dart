import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/mnemonics_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class MnemonicsRepository {
  final FirebaseFunctions cloudFunctions;
  final String routeUrl;

  MnemonicsRepository({
    required this.cloudFunctions,
    required this.routeUrl,
  });

  Future<(Mnemonic, LangfuseTraceId)> generate({
    required CardId cardId,
    required SessionId sessionId,
    required String question,
    required String answer,
    required LangfuseTraceId? previousLangfuseTraceId,
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
        'previousTraceId': previousLangfuseTraceId,
      }
    });

    final mnemonic = response.data['mnemonic'] as String;
    final traceId = response.data['traceId'] as String;

    return (mnemonic, traceId);
  }

  Future<String> append({
    required String mnemonic,
    required SessionId sessionId,
    required CardId cardId,
    required LangfuseTraceId? langfuseTraceId,
  }) async {
    final response = await cloudFunctions
        .httpsCallableFromUrl(routeUrl)
        .call<Map<String, dynamic>>({
      'destination': 'appendMnemonic',
      'payload': {
        'cardId': cardId,
        'sessionId': sessionId,
        'mnemonic': mnemonic,
        'traceId': langfuseTraceId,
      }
    });

    return response.data['updatedAnswer'] as String;
  }

  Future<void> dislike({
    required LangfuseTraceId? langfuseTraceId,
  }) async {
    await cloudFunctions.httpsCallableFromUrl(routeUrl).call({
      'destination': 'dislikeMnemonic',
      'payload': {
        'traceId': langfuseTraceId,
      }
    });
  }
}
