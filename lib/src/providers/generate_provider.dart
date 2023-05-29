import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final generateStateProvider =
    StateNotifierProvider<GenerateNotifier, GenerateState>(
  (ref) {
    final logger = ref.watch(loggerProvider);
    final sessionRepository = ref.watch(sessionRepositoryProvider);
    final textEditingController = ref.watch(slideTextFieldControllerProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    return GenerateNotifier(
      logger: logger,
      sessionRepository: sessionRepository,
      textEditingController: textEditingController,
      userRepository: userRepository,
    );
  },
);

final localCards = [
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of Spain?',
    answer: 'Madrid',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of Portugal?',
    answer: 'Lisbon',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of the Netherlands?',
    answer: 'Amsterdam',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of France?',
    answer: 'Paris',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of Germany?',
    answer: 'Berlin',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    question: 'What is the capital of Italy?',
    answer: 'Rome',
  ),
];

class GenerateNotifier extends StateNotifier<GenerateState> {
  final Logger logger;
  final SessionRepository sessionRepository;
  final TextEditingController textEditingController;
  final UserRepository userRepository;

  GenerateNotifier({
    required this.logger,
    required this.sessionRepository,
    required this.textEditingController,
    required this.userRepository,
  }) : super(const GenerateState.initial());

  Future<void> submit({
    required CardGenrationSize size,
  }) async {
    logger.d("Generating cards...");

    if (size.isPlus()) {
      throw PlusMembershipRequiredException();
    }

    if (textEditingController.text.length < 200) {
      throw TooShortInputException();
    }

    if (textEditingController.text.length > 15000) {
      throw TooLongInputException();
    }

    state = const GenerateState.loading();

    if (!userRepository.isSignIn()) {
      logger.d("User is not signed in, signing in...");
      await userRepository.signIn();
    }

    final sessionId = await sessionRepository.startSession(
      slideContent: textEditingController.text,
      numberOfCards: size.toInt(),
    );
    bool isCompleted = false;
    while (!isCompleted) {
      final getCardsResponse = await sessionRepository.getCards(
        sessionId: sessionId,
      );

      final cards = List<AnkiCard>.of(getCardsResponse.cards ?? [])
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      if (getCardsResponse.error != null) {
        state = GenerateState.error(
          message: getCardsResponse.error!,
          generatedCards: cards,
          language: getCardsResponse.language,
        );
        return;
      }

      if (getCardsResponse.isCompleted) {
        isCompleted = true;
        state = GenerateState.success(
          generatedCards: cards,
          downloadUrl: getCardsResponse.csv?.downloadUrl,
          language: getCardsResponse.language,
        );
      } else {
        state = GenerateState.loading(
          alreadyGeneratedCards: cards,
          language: getCardsResponse.language,
        );
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }
}

class TooShortInputException implements Exception {}

class TooLongInputException implements Exception {}

class PlusMembershipRequiredException implements Exception {}
