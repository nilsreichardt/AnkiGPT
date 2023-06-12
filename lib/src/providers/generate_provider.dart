import 'dart:async';

import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/anki_card.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/slide_text_field_controller_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  StreamSubscription<DocumentSnapshot<SessionDto>>? _subscription;
  PlatformFile? _pickedFile;
  bool get _hasPickedFile => _pickedFile != null;

  @override
  GenerateState build() {
    ref.onDispose(() => _stopSubscription());
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

      final cards = dto.cards?.values.toList() ?? [];
      if (dto.status == SessionStatus.completed) {
        _stopSubscription();
        state = GenerateState.success(
          sessionId: sessionId!,
          generatedCards: cards,
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
        alreadyGeneratedCards: cards,
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

  void _stopSubscription() {
    _logger.d("Stopping subscription for generating cards...");
    _subscription?.cancel();
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
