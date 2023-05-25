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
    front: 'What is the capital of Spain?',
    back: 'Madrid',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    front: 'What is the capital of Portugal?',
    back: 'Lisbon',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    front: 'What is the capital of the Netherlands?',
    back: 'Amsterdam',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    front: 'What is the capital of France?',
    back: 'Paris',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    front: 'What is the capital of Germany?',
    back: 'Berlin',
  ),
  AnkiCard(
    createdAt: DateTime.now(),
    front: 'What is the capital of Italy?',
    back: 'Rome',
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

  Future<void> submit() async {
    logger.d("Generating cards...");

    if (!userRepository.isSignIn()) {
      logger.d("User is not signed in, signing in...");
      await userRepository.signIn();
    }

    state = const GenerateState.loading();

    final sessionId = await sessionRepository.startSession(
      slideContent: textEditingController.text,
      numberOfCards: 3,
    );
    bool isCompleted = false;
    while (!isCompleted) {
      final getCardsResponse = await sessionRepository.getCards(
        sessionId: sessionId,
      );

      final cards = List<AnkiCard>.of(getCardsResponse.cards ?? [])
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      if (getCardsResponse.isCompleted) {
        isCompleted = true;
        state = GenerateState.success(
          generatedCards: cards,
          downloadUrl: getCardsResponse.csv?.downloadUrl,
        );
      } else {
        state = GenerateState.loading(alreadyGeneratedCards: cards);
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }
}
