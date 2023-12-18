// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_text_editing_controller_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$answerTextEditingControllerProviderHash() =>
    r'512811cb9977e240102090334f0541a17847b7f5';

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

typedef AnswerTextEditingControllerProviderRef
    = ProviderRef<TextEditingController>;

/// See also [answerTextEditingControllerProvider].
@ProviderFor(answerTextEditingControllerProvider)
const answerTextEditingControllerProviderProvider =
    AnswerTextEditingControllerProviderFamily();

/// See also [answerTextEditingControllerProvider].
class AnswerTextEditingControllerProviderFamily
    extends Family<TextEditingController> {
  /// See also [answerTextEditingControllerProvider].
  const AnswerTextEditingControllerProviderFamily();

  /// See also [answerTextEditingControllerProvider].
  AnswerTextEditingControllerProviderProvider call(
    String cardId,
  ) {
    return AnswerTextEditingControllerProviderProvider(
      cardId,
    );
  }

  @override
  AnswerTextEditingControllerProviderProvider getProviderOverride(
    covariant AnswerTextEditingControllerProviderProvider provider,
  ) {
    return call(
      provider.cardId,
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
  String? get name => r'answerTextEditingControllerProviderProvider';
}

/// See also [answerTextEditingControllerProvider].
class AnswerTextEditingControllerProviderProvider
    extends Provider<TextEditingController> {
  /// See also [answerTextEditingControllerProvider].
  AnswerTextEditingControllerProviderProvider(
    this.cardId,
  ) : super.internal(
          (ref) => answerTextEditingControllerProvider(
            ref,
            cardId,
          ),
          from: answerTextEditingControllerProviderProvider,
          name: r'answerTextEditingControllerProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$answerTextEditingControllerProviderHash,
          dependencies: AnswerTextEditingControllerProviderFamily._dependencies,
          allTransitiveDependencies: AnswerTextEditingControllerProviderFamily
              ._allTransitiveDependencies,
        );

  final String cardId;

  @override
  bool operator ==(Object other) {
    return other is AnswerTextEditingControllerProviderProvider &&
        other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
