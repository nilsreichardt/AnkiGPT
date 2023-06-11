import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dislike_repository.g.dart';

@riverpod
DislikeRepository dislikeRepository(DislikeRepositoryRef ref) {
  final cloudFunctions = ref.watch(cloudFunctionsProvider);
  final routeFunctionsUrl = ref.read(routeFunctionsUrlProvider);
  return DislikeRepository(cloudFunctions, routeFunctionsUrl);
}

class DislikeRepository {
  const DislikeRepository(
    this._functions,
    this._routeFunctionsUrl,
  );

  final FirebaseFunctions _functions;
  final String _routeFunctionsUrl;

  Future<void> dislike({
    required SessionId sessionId,
    required CardId cardId,
    required List<CardFeedbackType>? types,
    required FeedbackText? text,
  }) async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'dislikeCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
        'types': types?.map((t) => t.name).toList(),
        'text': text,
      },
    });
  }

  Future<void> undoDislike({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'undoDislikeCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
      },
    });
  }
}
