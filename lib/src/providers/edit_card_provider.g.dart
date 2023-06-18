// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editAnswerHash() => r'6f2c1ba6382364d0d7e25338192e1a97c601b738';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef EditAnswerRef = AutoDisposeFutureProviderRef<void>;

/// See also [editAnswer].
@ProviderFor(editAnswer)
const editAnswerProvider = EditAnswerFamily();

/// See also [editAnswer].
class EditAnswerFamily extends Family<AsyncValue<void>> {
  /// See also [editAnswer].
  const EditAnswerFamily();

  /// See also [editAnswer].
  EditAnswerProvider call({
    required String answer,
    required String cardId,
    required String sessionId,
  }) {
    return EditAnswerProvider(
      answer: answer,
      cardId: cardId,
      sessionId: sessionId,
    );
  }

  @override
  EditAnswerProvider getProviderOverride(
    covariant EditAnswerProvider provider,
  ) {
    return call(
      answer: provider.answer,
      cardId: provider.cardId,
      sessionId: provider.sessionId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editAnswerProvider';
}

/// See also [editAnswer].
class EditAnswerProvider extends AutoDisposeFutureProvider<void> {
  /// See also [editAnswer].
  EditAnswerProvider({
    required this.answer,
    required this.cardId,
    required this.sessionId,
  }) : super.internal(
          (ref) => editAnswer(
            ref,
            answer: answer,
            cardId: cardId,
            sessionId: sessionId,
          ),
          from: editAnswerProvider,
          name: r'editAnswerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editAnswerHash,
          dependencies: EditAnswerFamily._dependencies,
          allTransitiveDependencies:
              EditAnswerFamily._allTransitiveDependencies,
        );

  final String answer;
  final String cardId;
  final String sessionId;

  @override
  bool operator ==(Object other) {
    return other is EditAnswerProvider &&
        other.answer == answer &&
        other.cardId == cardId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, answer.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$editQuestionHash() => r'af5433f57bcb47cf7a7ad9293c64f5439c2f2262';
typedef EditQuestionRef = AutoDisposeFutureProviderRef<void>;

/// See also [editQuestion].
@ProviderFor(editQuestion)
const editQuestionProvider = EditQuestionFamily();

/// See also [editQuestion].
class EditQuestionFamily extends Family<AsyncValue<void>> {
  /// See also [editQuestion].
  const EditQuestionFamily();

  /// See also [editQuestion].
  EditQuestionProvider call({
    required String question,
    required String cardId,
    required String sessionId,
  }) {
    return EditQuestionProvider(
      question: question,
      cardId: cardId,
      sessionId: sessionId,
    );
  }

  @override
  EditQuestionProvider getProviderOverride(
    covariant EditQuestionProvider provider,
  ) {
    return call(
      question: provider.question,
      cardId: provider.cardId,
      sessionId: provider.sessionId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editQuestionProvider';
}

/// See also [editQuestion].
class EditQuestionProvider extends AutoDisposeFutureProvider<void> {
  /// See also [editQuestion].
  EditQuestionProvider({
    required this.question,
    required this.cardId,
    required this.sessionId,
  }) : super.internal(
          (ref) => editQuestion(
            ref,
            question: question,
            cardId: cardId,
            sessionId: sessionId,
          ),
          from: editQuestionProvider,
          name: r'editQuestionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editQuestionHash,
          dependencies: EditQuestionFamily._dependencies,
          allTransitiveDependencies:
              EditQuestionFamily._allTransitiveDependencies,
        );

  final String question;
  final String cardId;
  final String sessionId;

  @override
  bool operator ==(Object other) {
    return other is EditQuestionProvider &&
        other.question == question &&
        other.cardId == cardId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, question.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
