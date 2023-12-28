import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/widgets.dart';
import 'package:queue/queue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_answer_provider.g.dart';

@Riverpod(keepAlive: true)
class EditAnswer extends _$EditAnswer {
  static const _debounceKey = 'edit_answer';
  Duration _debounceDuration = const Duration(milliseconds: 1000);
  final _queue = Queue();

  @override
  void build() {
    return;
  }

  void debounce({
    required CardId cardId,
    required SessionId sessionId,
    required String answer,
  }) {
    EasyDebounce.debounce(_debounceKey, _debounceDuration, () {
      ref.read(loggerProvider).t('Edit answer of card $cardId');
      _queue.add(() async {
        final repository = ref.read(sessionRepositoryProvider);
        await repository.editAnswer(
          sessionId: sessionId,
          cardId: cardId,
          answer: answer,
        );
      }).catchError((e) {
        if (e is QueueCancelledException) {
          // We ignore this error because it is thrown when the user signs out.
          return;
        }
      });
    });
  }

  /// Sets the debounce duration for testing purposes.
  ///
  /// This method is used to set the debounce duration for testing purposes. It
  /// takes a [Duration] parameter representing the new debounce duration.
  @visibleForTesting
  void setDebounceDuration(Duration duration) {
    _debounceDuration = duration;
  }

  void clear() {
    EasyDebounce.cancel(_debounceKey);
    _queue.cancel();
  }
}
