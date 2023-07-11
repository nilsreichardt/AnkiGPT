import 'dart:async';

import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/watch_view.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'watch_provider.g.dart';

@riverpod
class Watch extends _$Watch {
  StreamSubscription<SessionDto?>? _subscription;
  Logger get _logger => ref.read(loggerProvider);
  SessionRepository get _repository => ref.read(sessionRepositoryProvider);

  @override
  WatchView build() {
    ref.onDispose(() => _stopSubscription());
    return const WatchView();
  }

  void watch({
    required String sessionId,
  }) {
    state = state.copyWith(
      isLoading: true,
      sessionId: sessionId,
    );

    _subscription = _repository.streamSession(sessionId).listen(
      (dto) {
        if (dto == null) {
          return;
        }

        _logger.d("Received session dto with ${dto.cards?.length} cards");

        final cards = (dto.cards?.values.toList() ?? []);
        ref.read(cardsListProvider.notifier).set(cards);

        final isDownloadAvailable = dto.csv == null;
        final downloadUrl = dto.csv?.downloadUrl;

        state = state.copyWith(
          downloadUrl: downloadUrl,
          error: dto.error,
          isLoading:
              dto.status == SessionStatus.running || !isDownloadAvailable,
          language: dto.language,
          fileName: dto.input.file?.name,
          inputText: dto.input.text,
        );
      },
      onError: (error, stackTrace) {
        _logger.e("Error while watching session: $error", error, stackTrace);
        state = state.copyWith(
          isLoading: false,
          error: 'Error while listing to session: $error',
        );
      },
    );
  }

  void _stopSubscription() {
    if (_subscription != null) {
      _logger.d("Stopping subscription for generating cards...");
      _subscription?.cancel();
    }
  }
}
