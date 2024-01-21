import 'dart:async';

import 'package:ankigpt/src/infrastructure/session_repository.dart';
import 'package:ankigpt/src/infrastructure/user_repository.dart';
import 'package:ankigpt/src/models/card_generation_size.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/models/input_type.dart';
import 'package:ankigpt/src/models/model.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:ankigpt/src/providers/analytics_provider.dart';
import 'package:ankigpt/src/providers/clear_session_state_provider.dart';
import 'package:ankigpt/src/providers/current_usage_provider.dart';
import 'package:ankigpt/src/providers/has_plus_provider.dart';
import 'package:ankigpt/src/providers/input_text_field_controller.dart';
import 'package:ankigpt/src/providers/logger/logger_provider.dart';
import 'package:ankigpt/src/providers/options_provider.dart';
import 'package:ankigpt/src/providers/router_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:ankigpt/src/providers/user_repository_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'generate_provider.g.dart';

/// Defines the number of cards every free user has per month available.
const freeUsageLimitPerMonth = 100;

const freeMnemonicsUsagePerMonth = 5;

const plusGpt4UsageLimitPerMonth = 1000;

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
  int get _currentGpt4Usage => ref.read(currentGpt4UsageProvider);
  Analytics get _analytics => ref.read(analyticsProvider);
  static const _analyticsPage = 'generate';

  PlatformFile? _pickedFile;
  bool get _hasPickedFile => _pickedFile != null;
  String? _pdfPassword;

  @override
  GenerateState build() {
    return const GenerateState.initial();
  }

  Future<void> submit() async {
    final options = ref.read(optionsControllerProvider);

    _logger.d("Generating cards...");

    if (!_hasPlus && options.hasPlusOption()) {
      _logPlusRequiredToGenerate();
      throw PlusMembershipRequiredException();
    }

    final text = _textEditingController.text;
    if (!_hasPickedFile) {
      _throwIfTextInputIsInvalid(text);
    }

    _throwIfFreeLimitReached(options.size);
    _throwIfGpt4LimitReached(options.size, options.model);

    // This code requires the user to have an account (anonymous doesn't count).
    // if (!ref.read(hasAccount2Provider)) {
    //   ref.read(wantsToGenerateProvider.notifier).set(true);
    //   ref.read(routerProvider).go('/account');
    //   return;
    // }

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
        numberOfCards: options.size.toInt(),
        sessionId: sessionId,
        model: options.model.snakeCaseName,
        input: Input(
          text: text.isEmpty ? null : text,
          type: _hasPickedFile ? InputType.file : InputType.text,
          file: _hasPickedFile
              ? FileInput(
                  name: _pickedFile!.name,
                  pdfPassword: _pdfPassword,
                )
              : null,
        ),
      );
      _logStartSession(options.size);

      _logger.d("Started session with id: $sessionId");

      // Reset state
      state = const GenerateState.initial();
      ref.read(pickedFileProvider.notifier).set(null);
      _pickedFile = null;
      _textEditingController.clear();
      _pdfPassword = null;
      ref.read(optionsControllerProvider.notifier).reset();

      final router = ref.read(routerProvider);
      router.go('/deck/$sessionId');
    } catch (e, s) {
      _logger.e("Failed to generate cards", error: e, stackTrace: s);

      if (e is FirebaseFunctionsException) {
        if (e.message == 'password-required-exception') {
          state = const GenerateState.passwordRequired();
          return;
        }

        state = GenerateState.error(
            message: _getErrorMessageForFunctionsException(e));
        return;
      }
      state = GenerateState.error(message: '$e');
    }
  }

  String _getErrorMessageForFunctionsException(FirebaseFunctionsException e) {
    if (e.message == 'too-long-input-exception') {
      return 'Your input is too long. Please try again with a shorter input.';
    }

    if (e.message == 'too-less-input-exception') {
      return 'Your input is too short. Please try again with a longer input (at least 400 characters). In case you uploaded a file, ensure that the file contains enough text (text from images is not supported). Or copy the text from the file and paste it into the text field.';
    }

    if (e.message == 'no-input-provided-exception') {
      return 'The provided input was empty. Please try again with a non-empty input. In case you uploaded a file, ensure that the file contains enough text (text from images is not supported). Or copy the text from the file and paste it into the text field.';
    }

    if (e.message == 'could-not-read-pdf-exception') {
      return 'The provided file could not be read. Please try again with a different file. Or copy the text from the file and paste it into the text field.';
    }

    if (e.message == 'unknown-language-exception') {
      return 'It was not possible to detect the language of the input. Please try again with a different input. In case you uploading a file, ensure that the file contains enough text (text from images is not supported). Also, it could be that the text in your file is not readable by our OCR. In this case, please copy the text from the file and paste it into the text field.';
    }

    return 'An unknown error occurred. Please try again or contact the support.';
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

  void _throwIfGpt4LimitReached(CardGenrationSize size, Model model) {
    if (_hasPlus && model == Model.gpt4) {
      final remainingGpt4Limit = plusGpt4UsageLimitPerMonth - _currentGpt4Usage;
      if (remainingGpt4Limit < size.toInt()) {
        throw Gpt4LimitExceededException(
          currentDeckSize: size.toInt(),
          remainingGpt4Limit: remainingGpt4Limit,
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

  void setPassword(String? password) {
    _pdfPassword = password;
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
      if (e is FirebaseException && e.code == 'unauthorized') {
        _logger.e('Unauthorized to upload file', error: e);
        state = const GenerateState.error(
            message:
                'Uploading the file was blocked. This could be because your file is too large. Please try again with a smaller file (< 100 MB).');
        return false;
      }

      state = GenerateState.error(message: 'Failed to upload file: $e');
      _logger.e('Failed to upload file', error: e);
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
    final size = ref.read(optionsControllerProvider).size;
    if (!size.isAvailableForFiles()) {
      ref.read(optionsControllerProvider.notifier).setSize(
          _hasPlus ? CardGenrationSize.fifty : CardGenrationSize.twenty);
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

class Gpt4LimitExceededException implements Exception {
  const Gpt4LimitExceededException({
    required this.currentDeckSize,
    required this.remainingGpt4Limit,
  });

  /// The deck size that the user tried to generate.
  final int currentDeckSize;

  /// The number of cards the user has left for GPT-4.
  final int remainingGpt4Limit;
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
