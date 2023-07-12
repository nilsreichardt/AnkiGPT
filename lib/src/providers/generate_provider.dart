import 'dart:async';

import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/clear_session_state_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'generate_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [hasPlus])
class GenerateNotifier extends _$GenerateNotifier {
  Logger get _logger => ref.read(loggerProvider);
  TextEditingController get _textEditingController =>
      ref.read(inputTextFieldControllerProvider);
  UserRepository get _userRepository => ref.read(userRepositoryProvider);
  SessionRepository get _sessionRepository =>
      ref.read(sessionRepositoryProvider);
  bool get _hasPlus => ref.read(hasPlusProvider);

  PlatformFile? _pickedFile;
  bool get _hasPickedFile => _pickedFile != null;

  @override
  GenerateState build() {
    return const GenerateState.initial();
  }

  Future<void> submit() async {
    final size = ref.read(generationSizeProvider);

    _logger.d("Generating cards...");

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

    SessionId? sessionId = _generateSessionId();
    if (_hasPickedFile) {
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

    await _sessionRepository.startSession(
      numberOfCards: size.toInt(),
      sessionId: sessionId,
      input: Input(
        text: text.isEmpty ? null : text,
        type: _hasPickedFile ? InputType.file : InputType.text,
        file: _hasPickedFile ? FileInput(name: _pickedFile!.name) : null,
      ),
    );

    _logger.d("Started session with id: $sessionId");
  }

  void _validateTextInput(String text) {
    if (text.length < 400) {
      throw TooShortInputException();
    }

    if (text.length > 5000 && !_hasPlus) {
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

  void reset() {
    state = const GenerateState.initial();
    ref.read(clearSessionStateProvider.notifier).clear();
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

@riverpod
bool hasPickedFile(HasPickedFileRef ref) {
  final pickedFile = ref.watch(pickedFileProvider);
  return pickedFile != null;
}
