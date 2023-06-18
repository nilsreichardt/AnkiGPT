import 'dart:async';

import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/cards_list_provider.dart';
import 'package:ankigpt/src/providers/delete_card_provider.dart';
import 'package:ankigpt/src/providers/edit_card_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/is_editing_card_loading.dart';
import 'package:ankigpt/src/providers/is_search_loading_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/search_query_provider.dart';
import 'package:ankigpt/src/providers/search_text_field_controller.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'generate_provider.g.dart';

@Riverpod(keepAlive: true)
class GenerateNotifier extends _$GenerateNotifier {
  Logger get _logger => ref.read(loggerProvider);
  TextEditingController get _textEditingController =>
      ref.read(slideTextFieldControllerProvider);
  UserRepository get _userRepository => ref.read(userRepositoryProvider);
  SessionRepository get _sessionRepository =>
      ref.read(sessionRepositoryProvider);
  bool get _hasPlus => ref.read(hasPlusProvider);
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  bool get _isSearching =>
      ref.read(searchTextFieldControllerProvider).text.isNotEmpty;

  StreamSubscription<DocumentSnapshot<SessionDto>>? _subscription;
  PlatformFile? _pickedFile;
  bool get _hasPickedFile => _pickedFile != null;

  /// A local copy of cards that have been generated.
  ///
  /// Is being used to show all cards when user is cancelling the search.
  List<AnkiCard> _localCards = [];

  @override
  GenerateState build() {
    ref.onDispose(() => _stopSubscription());
    return const GenerateState.initial();
  }

  Future<void> submit() async {
    final size = ref.read(generationSizeProvider);

    // Stopping subscription because it could be running when watch() has been called before.
    _stopSubscription();

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

    final text = _textEditingController.text;

    if (!_hasPickedFile) {
      _validateTextInput(text);
    }

    state = GenerateState.loading(
      isUploadFile: _hasPickedFile,
    );

    UserId? userId = _userRepository.getUserId();
    if (!_userRepository.isSignedIn()) {
      _logger.d("User is not signed in, signing in...");
      userId = await _userRepository.signIn();
    }

    SessionId? sessionId;
    if (_hasPickedFile) {
      // If the user has picked a file, the client generates the session id. In the other case, the server generates it.
      sessionId = _generateSessionId();
      final successful = await _uploadFile(
        sessionId: sessionId,
        userId: userId!,
      );
      if (!successful) {
        return;
      }

      state = GenerateState.loading(
        sessionId: sessionId,
        isUploadFile: false,
      );
    }

    sessionId = await _sessionRepository.startSession(
      numberOfCards: size.toInt(),
      sessionId: sessionId,
      input: Input(
        text: text.isEmpty ? null : text,
        type: _hasPickedFile ? InputType.file : InputType.text,
        file: _hasPickedFile ? FileInput(name: _pickedFile!.name) : null,
      ),
    );

    _subscription = _firestore
        .collection('Sessions')
        .doc(sessionId)
        .withConverter(
          fromFirestore: (doc, options) =>
              SessionDto.fromJsonWithInjectedId(sessionId!, doc.data()!),
          toFirestore: (_, __) => throw UnimplementedError(),
        )
        .snapshots()
        .listen((event) {
      final dto = event.data();
      if (dto == null) {
        return;
      }

      _logger.d("Received session dto with ${dto.cards?.length} cards");

      if (dto.status == SessionStatus.error) {
        _stopSubscription();
        state = GenerateState.error(
          message: dto.error!,
          sessionId: sessionId!,
          language: dto.language,
        );
        return;
      }

      final cards = (dto.cards?.values.toList() ?? [])..sortByCreatedAt();
      _localCards = cards;
      ref.read(cardsListProvider.notifier).set(cards);

      if (dto.status == SessionStatus.completed) {
        state = GenerateState.success(
          sessionId: sessionId!,
          downloadUrl: dto.csv!.downloadUrl,
          language: dto.language,
        );
        return;
      }

      if (dto.status == SessionStatus.stopped) {
        _stopSubscription();
        state = const GenerateState.initial();
        return;
      }

      state = GenerateState.loading(
        sessionId: sessionId,
        language: dto.language,
      );
    });
  }

  void _validateTextInput(String text) {
    if (text.length < 200) {
      throw TooShortInputException();
    }

    if (text.length > 10000) {
      throw TooLongInputException();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      clearSearch();
      return;
    }

    ref.read(isSearchLoadingProvider.notifier).set(true);
    const debounceDuration = Duration(milliseconds: 1000);
    EasyDebounce.debounce('search', debounceDuration, () async {
      _logger.d("Searching for: $query");

      ref.read(searchQueryProvider.notifier).set(query);
      ref.read(isSearchLoadingProvider.notifier).set(false);
    });
  }

  Future<void> clearSearch() async {
    _logger.d("Resetting search");

    final sessionId = state.maybeMap(
      success: (state) => state.sessionId,
      orElse: () => null,
    )!;
    final language = state.maybeMap(
      success: (state) => state.language,
      orElse: () => null,
    );
    final downloadUrl = state.maybeMap(
      success: (state) => state.downloadUrl,
      orElse: () => null,
    );

    ref.read(searchTextFieldControllerProvider).text = '';
    ref.read(isSearchLoadingProvider.notifier).set(false);
    EasyDebounce.cancel('search');

    // Wait a short moment to first render the UI with the empty search text field.
    await Future.delayed(const Duration(milliseconds: 16));

    state = GenerateState.success(
      sessionId: sessionId,
      language: language,
      downloadUrl: downloadUrl,
    );
  }

  void fireSearch() {
    EasyDebounce.fire('search');
  }

  Future<bool> _uploadFile({
    required SessionId sessionId,
    required UserId userId,
  }) async {
    _logger.d('Starting to upload file');
    try {
      await _sessionRepository.uploadFile(
        sessionId: sessionId,
        userId: userId,
        file: _pickedFile!,
      );
      _logger.d('Uploaded file');
      return true;
    } catch (e) {
      state = GenerateState.error(
        message: 'Failed to upload file: $e',
        sessionId: sessionId,
      );
      _logger.e('Failed to upload file', e);
      return false;
    }
  }

  SessionId _generateSessionId() {
    final id = const Uuid().v4();
    _logger.d("Generated session id: $id");
    return id;
  }

  AnkiCard? deleteCard(CardId cardId) {
    _logger.d("Delete card with id: $cardId");

    final sessionId = state.maybeMap(
      success: (s) => s.sessionId,
      loading: (s) => s.sessionId,
      orElse: () => null,
    );
    if (sessionId == null) {
      throw Exception("Session id is null");
    }

    final cardToDelete = _localCards.firstWhere((c) => c.id == cardId);
    final newCardsList = _localCards.where((c) => c.id != cardId).toList();

    if (_isSearching) {
      final searchQuery = ref.read(searchTextFieldControllerProvider).text;
      state = GenerateState.success(
        sessionId: sessionId,
        language: state.maybeMap(
          success: (s) => s.language,
          orElse: () => null,
        ),
        generatedCards: _makeSearch((newCardsList, searchQuery)),
        downloadUrl: state.maybeMap(
          success: (s) => s.downloadUrl,
          orElse: () => null,
        ),
      );
    } else {
      state = GenerateState.loading(
        sessionId: sessionId,
        alreadyGeneratedCards: newCardsList,
      );
    }

    _localCards = newCardsList;
    ref.read(deleteCardProvider(cardId: cardId, sessionId: sessionId));
    return cardToDelete;
  }

  void editAnswer(CardId cardId, String text) {
    ref.read(isEditingCardLoadingProvider.notifier).set(true);
    EasyDebounce.debounce('answer', const Duration(seconds: 1), () async {
      _logger.d("Editing answer of card with id: $cardId");
      final sessionId = state.maybeMap(
        success: (s) => s.sessionId,
        loading: (s) => s.sessionId,
        orElse: () => null,
      );
      if (sessionId == null) {
        return;
      }

      final cards = state.maybeMap(
        success: (s) => s.generatedCards,
        loading: (s) => s.alreadyGeneratedCards,
        orElse: () => <AnkiCard>[],
      );
      final newCardsList = cards.map((c) {
        if (c.id == cardId) {
          return c.copyWith(answer: text);
        }
        return c;
      }).toList();

      _localCards = newCardsList;

      await ref.read(
        editAnswerProvider(
          answer: text,
          cardId: cardId,
          sessionId: sessionId,
        ).future,
      );
      _logger.w('Edited answer of card with id: $cardId');
      ref.read(isEditingCardLoadingProvider.notifier).set(false);
    });
  }

  void editQuestion(CardId cardId, String text) {
    ref.read(isEditingCardLoadingProvider.notifier).set(true);
    EasyDebounce.debounce('question', const Duration(seconds: 1), () async {
      _logger.d("Editing question of card with id: $cardId");
      final sessionId = state.maybeMap(
        success: (s) => s.sessionId,
        loading: (s) => s.sessionId,
        orElse: () => null,
      );
      if (sessionId == null) {
        return;
      }

      final cards = state.maybeMap(
        success: (s) => s.generatedCards,
        loading: (s) => s.alreadyGeneratedCards,
        orElse: () => <AnkiCard>[],
      );
      final newCardsList = cards.map((c) {
        if (c.id == cardId) {
          return c.copyWith(question: text);
        }
        return c;
      }).toList();

      _localCards = newCardsList;

      await ref.read(
        editQuestionProvider(
          question: text,
          cardId: cardId,
          sessionId: sessionId,
        ).future,
      );
      ref.read(isEditingCardLoadingProvider.notifier).set(false);
    });
  }

  void restoreCard(CardId cardId, {AnkiCard? card}) {
    _logger.d("Restoring card with id: $cardId");

    final sessionId = state.maybeMap(
      success: (s) => s.sessionId,
      loading: (s) => s.sessionId,
      orElse: () => null,
    );
    if (sessionId == null) {
      return;
    }

    final cards = state.maybeMap(
      success: (s) => s.generatedCards,
      loading: (s) => s.alreadyGeneratedCards,
      orElse: () => <AnkiCard>[],
    );
    final restoredList = [
      ...cards,
      if (card != null) card,
    ];
    final language = state.maybeMap(
      success: (s) => s.language,
      orElse: () => null,
    );
    if (_isSearching) {
      final searchQuery = ref.read(searchTextFieldControllerProvider).text;
      state = GenerateState.success(
        sessionId: sessionId,
        language: state.maybeMap(
          success: (s) => s.language,
          orElse: () => null,
        ),
        generatedCards: _makeSearch((restoredList, searchQuery)),
        downloadUrl: state.maybeMap(
          success: (s) => s.downloadUrl,
          orElse: () => null,
        ),
      );
    } else {
      state = GenerateState.loading(
        sessionId: sessionId,
        language: language,
        alreadyGeneratedCards: restoredList..sortByCreatedAt(),
      );
    }
    if (card != null) {
      _localCards.add(card);
    }
    ref.read(undoDeleteCardProvider(cardId: cardId, sessionId: sessionId));
  }

  void _stopSubscription() {
    if (_subscription != null) {
      _logger.d("Stopping subscription for generating cards...");
      _subscription?.cancel();
    }
  }

  void watch({
    required String sessionId,
    WatchData? data,
  }) {
    if (data == null) {
      state = const GenerateState.loading();
    } else {
      state = GenerateState.success(
        sessionId: sessionId,
        generatedCards: data.cards,
        downloadUrl: data.downloadUrl,
        language: data.language,
      );
    }

    _subscription = _firestore
        .collection('Sessions')
        .doc(sessionId)
        .withConverter(
          fromFirestore: (doc, options) =>
              SessionDto.fromJsonWithInjectedId(sessionId, doc.data()!),
          toFirestore: (_, __) => throw UnimplementedError(),
        )
        .snapshots()
        .listen((event) {
      final dto = event.data();
      if (dto == null) {
        return;
      }

      _logger.d("Received session dto with ${dto.cards?.length} cards");

      final cards = (dto.cards?.values.toList() ?? [])..sortByCreatedAt();
      _localCards = cards;
      final searchQuery = ref.read(searchTextFieldControllerProvider).text;

      if (dto.csv == null) {
        state = GenerateState.loading(
          sessionId: sessionId,
          alreadyGeneratedCards: _makeSearch((cards, searchQuery)),
          language: dto.language,
        );
        return;
      }

      if (dto.status == SessionStatus.error) {
        _stopSubscription();
        state = GenerateState.error(
          message: dto.error!,
          sessionId: sessionId,
          language: dto.language,
        );
        return;
      }

      ref.read(cardsListProvider.notifier).set(cards);
      state = GenerateState.success(
        sessionId: sessionId,
        generatedCards: _makeSearch((cards, searchQuery)),
        downloadUrl: dto.csv!.downloadUrl,
        language: dto.language,
      );
    }, onError: (e) {
      _stopSubscription();
      _logger.e("Error while listening to session", e);
      state = GenerateState.error(
        message: 'Error while listening to session: $e',
        sessionId: sessionId,
      );
    });
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

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      type: FileType.custom,
    );

    if (result == null || result.files.isEmpty) return;
    _pickedFile = result.files.first;
    ref.read(pickedFileProvider.notifier).set(_pickedFile);

    // Maybe increase the size, when the current size is the default one. Slides are usually longer so we can assume
    // that the user wants to generate more cards.
    final size = ref.read(generationSizeProvider);
    if (!size.isAvailableForFiles()) {
      ref.read(generationSizeProvider.notifier).set(CardGenrationSize.fifty);
    }
  }

  void clearPickedFile() {
    _pickedFile = null;
    ref.read(pickedFileProvider.notifier).set(_pickedFile);
  }

  List<AnkiCard> _makeSearch((List<AnkiCard> cards, String query) params) {
    if (params.$2.isEmpty) return params.$1;
    final filteredCards = params.$1.where((card) {
      final q = card.question.toLowerCase();
      final a = card.answer.toLowerCase();
      final queryLowerCase = params.$2.toLowerCase();
      return q.contains(queryLowerCase) || a.contains(queryLowerCase);
    }).toList();
    return filteredCards..sortByCreatedAt();
  }
}

class WatchData {
  final List<AnkiCard> cards;
  final String downloadUrl;
  final Language language;

  const WatchData({
    required this.cards,
    required this.downloadUrl,
    required this.language,
  });
}

class TooShortInputException implements Exception {}

class TooLongInputException implements Exception {}

class PlusMembershipRequiredException implements Exception {}

@riverpod
class PickedFile extends _$PickedFile {
  @override
  PlatformFile? build() {
    return null;
  }

  void set(PlatformFile? value) {
    state = value;
  }
}

extension on List<AnkiCard> {
  void sortByCreatedAt() {
    // Sort first by createdAt than by id. This way we can ensure that the order is always the same.
    sort((a, b) {
      final createdAtComparison = a.createdAt.compareTo(b.createdAt);
      if (createdAtComparison != 0) {
        return createdAtComparison;
      }
      return a.id.compareTo(b.id);
    });
  }
}
