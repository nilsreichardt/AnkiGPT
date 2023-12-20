import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/card_text_editing_controller_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/mnemonics_repository_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mnemonics_provider.freezed.dart';
part 'mnemonics_provider.g.dart';

typedef Mnemonic = String;
typedef LangfuseTraceId = String;

@riverpod
class MnemonicsController extends _$MnemonicsController {
  @override
  MnemonicsState build() {
    return const MnemonicsState.generating();
  }

  Future<void> generate({
    required CardId cardId,
    required SessionId sessionId,
    required String question,
    required String answer,
  }) async {
    final previousTraceId = state.maybeWhen(
      loaded: (_, traceId) => traceId,
      orElse: () => null,
    );
    state = const MnemonicsState.generating();

    try {
      final repository = ref.read(mnemonicsRepositoryProvider);
      final response = await repository.generate(
        answer: answer,
        question: question,
        cardId: cardId,
        sessionId: sessionId,
        previousLangfuseTraceId: previousTraceId,
      );

      state = MnemonicsState.loaded(
        mnemonic: response.$1,
        traceId: response.$2,
      );
    } on FirebaseFunctionsException catch (e) {
      switch (e.code) {
        case 'deadline-exceeded':
          state = const MnemonicsState.error(
              'The request timed out. Please try again.');
          break;
        case 'resource-exhausted':
          state = const MnemonicsState.error(
              'You have reached your monthly limit of mnemonics. Please upgrade to the plus plan to get unlimited mnemonics.');
          break;
        default:
          state = MnemonicsState.error('[${e.plugin}/${e.code}] ${e.message}}');
          break;
      }
    } on Exception catch (e) {
      state = MnemonicsState.error('$e');
    }
  }

  Future<void> append({
    required SessionId sessionId,
    required CardId cardId,
  }) async {
    final loadedState = state.map(
      generating: (state) => throw Exception('Mnemonic is generating'),
      appending: (state) => throw Exception('Mnemonic is appending'),
      error: (state) => throw Exception(state.message),
      loaded: (state) => state,
    );

    state = const MnemonicsState.appending();

    try {
      final repository = ref.read(mnemonicsRepositoryProvider);
      final updatedAnswer = await repository.append(
        mnemonic: loadedState.mnemonic,
        sessionId: sessionId,
        cardId: cardId,
        langfuseTraceId: loadedState.traceId,
      );

      final textEditingController =
          ref.read(answerTextEditingControllerProviderProvider(cardId));
      textEditingController.text = updatedAnswer;
    } on Exception catch (e) {
      state = MnemonicsState.error('$e');
    }
  }

  void update(String mnemonic) {
    final traceId = state.maybeWhen(
      loaded: (_, traceId) => traceId,
      orElse: () => null,
    );
    state = MnemonicsState.loaded(
      mnemonic: mnemonic,
      traceId: traceId,
    );
  }

  Future<void> dislike() async {
    final traceId = state.maybeWhen(
      loaded: (_, traceId) => traceId,
      orElse: () => null,
    );

    if (traceId == null) {
      ref.read(loggerProvider).d('Skipping dislike because traceId is null');
      return;
    }

    try {
      final repository = ref.read(mnemonicsRepositoryProvider);
      await repository.dislike(langfuseTraceId: traceId);
    } on Exception catch (e, s) {
      ref.read(loggerProvider).e('Could not dislike mnemonic', e, s);
    }
  }
}

@freezed
class MnemonicsState with _$MnemonicsState {
  const factory MnemonicsState.generating() = MnemonicsStateGenerating;
  const factory MnemonicsState.appending() = MnemonicsStateAppending;
  const factory MnemonicsState.error(String message) = MnemonicsStateError;
  const factory MnemonicsState.loaded({
    required Mnemonic mnemonic,
    required LangfuseTraceId? traceId,
  }) = MnemonicsStateLoaded;
}
