import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:retry/retry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rename_deck_controller.g.dart';

@riverpod
class RenameDeckController extends _$RenameDeckController {
  @override
  RenameDeckState build(SessionId sessionId) {
    return const RenameDeckInitial(title: '');
  }

  void setTitle(String title) {
    state = RenameDeckInitial(title: title);
  }

  /// Saves the new deck title.
  ///
  /// Calls [SessionRepository.renameDeck] and updates the state accordingly.
  Future<void> save() async {
    state = RenameDeckLoading(title: state.title);
    try {
      final sessionRepository = ref.read(sessionRepositoryProvider);
      try {
        await retry(
          () async {
            await sessionRepository.renameDeck(
              sessionId: sessionId,
              title: state.title,
            );
          },
          maxAttempts: 3,
        );
        state = RenameDeckSuccess(title: state.title);
      } on Exception catch (e) {
        state = RenameDeckError(
          title: state.title,
          message: e.toString(),
        );
      }
    } catch (e) {
      state = RenameDeckInitial(title: state.title);
      rethrow;
    }
  }
}

sealed class RenameDeckState {
  const RenameDeckState({
    required this.title,
  });

  final String title;
}

class RenameDeckInitial extends RenameDeckState {
  const RenameDeckInitial({
    required super.title,
  });

  bool get isEmpty => title.isEmpty;
}

class RenameDeckLoading extends RenameDeckState {
  const RenameDeckLoading({
    required super.title,
  });
}

class RenameDeckError extends RenameDeckState {
  const RenameDeckError({
    required super.title,
    required this.message,
  });

  final String message;
}

class RenameDeckSuccess extends RenameDeckState {
  const RenameDeckSuccess({
    required super.title,
  });
}
