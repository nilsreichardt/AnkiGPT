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

/// See also [answerTextEditingControllerProvider].
@ProviderFor(answerTextEditingControllerProvider)
const answerTextEditingControllerProviderProvider =
    AnswerTextEditingControllerProviderFamily();

/// See also [answerTextEditingControllerProvider].
class AnswerTextEditingControllerProviderFamily
    extends Family<Raw<TextEditingController>> {
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
    extends Provider<Raw<TextEditingController>> {
  /// See also [answerTextEditingControllerProvider].
  AnswerTextEditingControllerProviderProvider(
    String cardId,
  ) : this._internal(
          (ref) => answerTextEditingControllerProvider(
            ref as AnswerTextEditingControllerProviderRef,
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
          cardId: cardId,
        );

  AnswerTextEditingControllerProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cardId,
  }) : super.internal();

  final String cardId;

  @override
  Override overrideWith(
    Raw<TextEditingController> Function(
            AnswerTextEditingControllerProviderRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AnswerTextEditingControllerProviderProvider._internal(
        (ref) => create(ref as AnswerTextEditingControllerProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cardId: cardId,
      ),
    );
  }

  @override
  ProviderElement<Raw<TextEditingController>> createElement() {
    return _AnswerTextEditingControllerProviderProviderElement(this);
  }

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

mixin AnswerTextEditingControllerProviderRef
    on ProviderRef<Raw<TextEditingController>> {
  /// The parameter `cardId` of this provider.
  String get cardId;
}

class _AnswerTextEditingControllerProviderProviderElement
    extends ProviderElement<Raw<TextEditingController>>
    with AnswerTextEditingControllerProviderRef {
  _AnswerTextEditingControllerProviderProviderElement(super.provider);

  @override
  String get cardId =>
      (origin as AnswerTextEditingControllerProviderProvider).cardId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
