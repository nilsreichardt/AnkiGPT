import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generate_provider.g.dart';

@riverpod
class GenerateNotifier extends _$GenerateNotifier {
  Logger get _logger => ref.read(loggerProvider);
  TextEditingController get _textEditingController =>
      ref.read(slideTextFieldControllerProvider);
  UserRepository get _userRepository => ref.read(userRepositoryProvider);
  SessionRepository get _sessionRepository =>
      ref.read(sessionRepositoryProvider);
  bool get _hasPlus => ref.read(hasPlusProvider);

  @override
  GenerateState build() {
    return const GenerateState.initial();
  }

  Future<void> submit({
    required CardGenrationSize size,
  }) async {
    _logger.d("Generating cards...");

    // state = GenerateState.success(
    //   sessionId: '123',
    //   generatedCards: localCards,
    //   downloadUrl: '',
    // );

    // return;

    if (!_hasPlus && size.isPlus()) {
      throw PlusMembershipRequiredException();
    }

    if (_textEditingController.text.length < 200) {
      throw TooShortInputException();
    }

    if (_textEditingController.text.length > 15000) {
      throw TooLongInputException();
    }

    state = const GenerateState.loading();

    if (!_userRepository.isSignIn()) {
      _logger.d("User is not signed in, signing in...");
      await _userRepository.signIn();
    }

    final sessionId = await _sessionRepository.startSession(
      slideContent: _textEditingController.text,
      numberOfCards: size.toInt(),
    );
    bool isCompleted = false;
    while (!isCompleted) {
      final getCardsResponse = await _sessionRepository.getCards(
        sessionId: sessionId,
      );

      final cards = List<AnkiCard>.of(getCardsResponse.cards ?? [])
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      if (getCardsResponse.error != null) {
        state = GenerateState.error(
          sessionId: getCardsResponse.sessionId!,
          message: getCardsResponse.error!,
          generatedCards: cards,
          language: getCardsResponse.language,
        );
        return;
      }

      if (getCardsResponse.isCompleted) {
        isCompleted = true;
        state = GenerateState.success(
          sessionId: getCardsResponse.sessionId!,
          generatedCards: cards,
          downloadUrl: getCardsResponse.csv?.downloadUrl,
          language: getCardsResponse.language,
        );
      } else {
        state = GenerateState.loading(
          sessionId: getCardsResponse.sessionId,
          alreadyGeneratedCards: cards,
          language: getCardsResponse.language,
        );
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }

  void setSuccess({
    required String sessionId,
    required List<AnkiCard> generatedCards,
    required String downloadUrl,
    required Language language,
  }) =>
      state = GenerateState.success(
        sessionId: sessionId,
        generatedCards: generatedCards,
        downloadUrl: downloadUrl,
        language: language,
      );

  void reset() {
    state = const GenerateState.initial();
  }
}

class TooShortInputException implements Exception {}

class TooLongInputException implements Exception {}

class PlusMembershipRequiredException implements Exception {}
