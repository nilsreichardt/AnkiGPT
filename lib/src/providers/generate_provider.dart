import 'dart:async';

import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:ankigpt/src/providers/analytics_provider.dart';
import 'package:ankigpt/src/providers/card_generation_size_provider.dart';
import 'package:ankigpt/src/providers/clear_session_state_provider.dart';
import 'package:ankigpt/src/providers/current_month_usage_provider.dart';
import 'package:ankigpt/src/providers/has_account_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/router_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:ankigpt/src/providers/wants_to_generate_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'generate_provider.g.dart';

/// Defines the number of cards every free user has per month available.
const freeUsageLimitPerMonth = 100;

@Riverpod(keepAlive: true, dependencies: [hasPlus])
class GenerateNotifier extends _$GenerateNotifier {
  Logger get _logger => ref.read(loggerProvider);
  TextEditingController get _textEditingController =>
      ref.read(inputTextFieldControllerProvider);
  UserRepository get _userRepository => ref.read(userRepositoryProvider);
  SessionRepository get _sessionRepository =>
      ref.read(sessionRepositoryProvider);
  bool get _hasPlus => ref.read(hasPlusProvider);
  int get _currentMonthUsage => ref.read(currentMonthUsageProvider);
  Analytics get _analytics => ref.read(analyticsProvider);
  static const _analyticsPage = 'generate';

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
      _logPlusRequiredToGenerate();
      throw PlusMembershipRequiredException();
    }

    final text = _textEditingController.text;
    if (!_hasPickedFile) {
      _throwIfTextInputIsInvalid(text);
    }

    _throwIfFreeLimitReached(size);

    if (!ref.read(hasAccount2Provider)) {
      ref.read(wantsToGenerateProvider.notifier).set(true);
      ref.read(routerProvider).go('/account');
      return;
    }

    state = const GenerateState.loading();

    try {
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
      _logStartSession(size);

      _logger.d("Started session with id: $sessionId");

      // Reset state
      state = const GenerateState.initial();
      ref.read(pickedFileProvider.notifier).set(null);
      _pickedFile = null;
      _textEditingController.clear();
      ref.read(generationSizeProvider.notifier).set(GenerationSize.defaultSize);

      final router = ref.read(routerProvider);
      router.go('/deck/$sessionId');
    } catch (e, s) {
      _logger.e("Failed to generate cards", e, s);
      state = GenerateState.error(message: '$e');
    }
  }

  void _throwIfFreeLimitReached(CardGenrationSize size) {
    if (!_hasPlus) {
      final remainingFreeLimit = freeUsageLimitPerMonth - _currentMonthUsage;
      if (remainingFreeLimit < size.toInt()) {
        _logFreeLimitExceeded();
        throw FreeLimitExceededException(
          currentDeckSize: size.toInt(),
          remainingFreeLimit: remainingFreeLimit,
        );
      }
    }
  }

  void _logPlusRequiredToGenerate() {
    unawaited(
      _analytics.logEvent(
        'plus_required_to_generate',
        page: _analyticsPage,
      ),
    );
  }

  void _logFreeLimitExceeded() {
    unawaited(
      _analytics.logEvent(
        'free_limit_exceeded',
        page: _analyticsPage,
      ),
    );
  }

  void _logStartSession(CardGenrationSize size) {
    unawaited(_analytics.logEvent(
      'start_session',
      params: {
        'size': size.name,
        'input_type': _hasPickedFile ? 'file' : 'text',
      },
      page: _analyticsPage,
    ));
  }

  void _throwIfTextInputIsInvalid(String text) {
    if (text.length < 400) {
      _logTooShortInput();
      throw TooShortInputException();
    }

    if (text.length > 4000 && !_hasPlus) {
      _logTooLongInputWithoutPlus();
      throw TooLongInputException();
    }
  }

  void _logTooLongInputWithoutPlus() {
    unawaited(_analytics.logEvent(
      'too_long_input_without_plus',
      page: _analyticsPage,
    ));
  }

  void _logTooShortInput() {
    unawaited(_analytics.logEvent(
      'too_short_input',
      page: _analyticsPage,
    ));
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
      state = GenerateState.error(message: 'Failed to upload file: $e');
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
      ref
          .read(generationSizeProvider.notifier)
          .set(_hasPlus ? CardGenrationSize.fifty : CardGenrationSize.twenty);
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

class FreeLimitExceededException implements Exception {
  const FreeLimitExceededException({
    required this.currentDeckSize,
    required this.remainingFreeLimit,
  });

  /// The deck size that the user tried to generate.
  final int currentDeckSize;

  /// The number of cards the user has left in the free version.
  final int remainingFreeLimit;
}

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
