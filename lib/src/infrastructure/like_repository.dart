import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/pages/widgets/card_feedback_dialog.dart';
import 'package:ankigpt/src/providers/cloud_firestore_provider.dart';
import 'package:ankigpt/src/providers/functions_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'like_repository.g.dart';

@riverpod
LikeRepository likeRepository(LikeRepositoryRef ref) {
  final cloudFunctions = ref.watch(cloudFunctionsProvider);
  final routeFunctionsUrl = ref.read(routeFunctionsUrlProvider);
  return LikeRepository(cloudFunctions, routeFunctionsUrl);
}

class LikeRepository {
  const LikeRepository(
    this._functions,
    this._routeFunctionsUrl,
  );

  final FirebaseFunctions _functions;
  final String _routeFunctionsUrl;

  Future<void> like({
    required SessionId sessionId,
    required CardId cardId,
    required FeedbackText? text,
  }) async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'likeCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
        'text': text,
      },
    });
  }

  Future<void> undoLike({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    await _functions.httpsCallableFromUrl(_routeFunctionsUrl).call({
      'destination': 'undoLikeCard',
      'payload': {
        'sessionId': sessionId,
        'cardId': cardId,
      },
    });
  }
}
