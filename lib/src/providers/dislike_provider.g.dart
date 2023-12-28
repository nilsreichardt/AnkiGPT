// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dislike_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dislikeCardHash() => r'b05ca1a0abc510b975345f48856179686d276c7f';

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

/// See also [dislikeCard].
@ProviderFor(dislikeCard)
const dislikeCardProvider = DislikeCardFamily();

/// See also [dislikeCard].
class DislikeCardFamily extends Family<AsyncValue<void>> {
  /// See also [dislikeCard].
  const DislikeCardFamily();

  /// See also [dislikeCard].
  DislikeCardProvider call({
    required String sessionId,
    required String cardId,
    Map<CardFeedbackType, bool>? checkboxes,
    String? text,
  }) {
    return DislikeCardProvider(
      sessionId: sessionId,
      cardId: cardId,
      checkboxes: checkboxes,
      text: text,
    );
  }

  @override
  DislikeCardProvider getProviderOverride(
    covariant DislikeCardProvider provider,
  ) {
    return call(
      sessionId: provider.sessionId,
      cardId: provider.cardId,
      checkboxes: provider.checkboxes,
      text: provider.text,
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
  String? get name => r'dislikeCardProvider';
}

/// See also [dislikeCard].
class DislikeCardProvider extends AutoDisposeFutureProvider<void> {
  /// See also [dislikeCard].
  DislikeCardProvider({
    required String sessionId,
    required String cardId,
    Map<CardFeedbackType, bool>? checkboxes,
    String? text,
  }) : this._internal(
          (ref) => dislikeCard(
            ref as DislikeCardRef,
            sessionId: sessionId,
            cardId: cardId,
            checkboxes: checkboxes,
            text: text,
          ),
          from: dislikeCardProvider,
          name: r'dislikeCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dislikeCardHash,
          dependencies: DislikeCardFamily._dependencies,
          allTransitiveDependencies:
              DislikeCardFamily._allTransitiveDependencies,
          sessionId: sessionId,
          cardId: cardId,
          checkboxes: checkboxes,
          text: text,
        );

  DislikeCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
    required this.cardId,
    required this.checkboxes,
    required this.text,
  }) : super.internal();

  final String sessionId;
  final String cardId;
  final Map<CardFeedbackType, bool>? checkboxes;
  final String? text;

  @override
  Override overrideWith(
    FutureOr<void> Function(DislikeCardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DislikeCardProvider._internal(
        (ref) => create(ref as DislikeCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
        cardId: cardId,
        checkboxes: checkboxes,
        text: text,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DislikeCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DislikeCardProvider &&
        other.sessionId == sessionId &&
        other.cardId == cardId &&
        other.checkboxes == checkboxes &&
        other.text == text;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, checkboxes.hashCode);
    hash = _SystemHash.combine(hash, text.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DislikeCardRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;

  /// The parameter `cardId` of this provider.
  String get cardId;

  /// The parameter `checkboxes` of this provider.
  Map<CardFeedbackType, bool>? get checkboxes;

  /// The parameter `text` of this provider.
  String? get text;
}

class _DislikeCardProviderElement extends AutoDisposeFutureProviderElement<void>
    with DislikeCardRef {
  _DislikeCardProviderElement(super.provider);

  @override
  String get sessionId => (origin as DislikeCardProvider).sessionId;
  @override
  String get cardId => (origin as DislikeCardProvider).cardId;
  @override
  Map<CardFeedbackType, bool>? get checkboxes =>
      (origin as DislikeCardProvider).checkboxes;
  @override
  String? get text => (origin as DislikeCardProvider).text;
}

String _$undoDislikeCardHash() => r'9e8c476f86ba26a3209145463340173ee32809ab';

/// See also [undoDislikeCard].
@ProviderFor(undoDislikeCard)
const undoDislikeCardProvider = UndoDislikeCardFamily();

/// See also [undoDislikeCard].
class UndoDislikeCardFamily extends Family<AsyncValue<void>> {
  /// See also [undoDislikeCard].
  const UndoDislikeCardFamily();

  /// See also [undoDislikeCard].
  UndoDislikeCardProvider call({
    required String sessionId,
    required String cardId,
  }) {
    return UndoDislikeCardProvider(
      sessionId: sessionId,
      cardId: cardId,
    );
  }

  @override
  UndoDislikeCardProvider getProviderOverride(
    covariant UndoDislikeCardProvider provider,
  ) {
    return call(
      sessionId: provider.sessionId,
      cardId: provider.cardId,
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
  String? get name => r'undoDislikeCardProvider';
}

/// See also [undoDislikeCard].
class UndoDislikeCardProvider extends AutoDisposeFutureProvider<void> {
  /// See also [undoDislikeCard].
  UndoDislikeCardProvider({
    required String sessionId,
    required String cardId,
  }) : this._internal(
          (ref) => undoDislikeCard(
            ref as UndoDislikeCardRef,
            sessionId: sessionId,
            cardId: cardId,
          ),
          from: undoDislikeCardProvider,
          name: r'undoDislikeCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$undoDislikeCardHash,
          dependencies: UndoDislikeCardFamily._dependencies,
          allTransitiveDependencies:
              UndoDislikeCardFamily._allTransitiveDependencies,
          sessionId: sessionId,
          cardId: cardId,
        );

  UndoDislikeCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
    required this.cardId,
  }) : super.internal();

  final String sessionId;
  final String cardId;

  @override
  Override overrideWith(
    FutureOr<void> Function(UndoDislikeCardRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UndoDislikeCardProvider._internal(
        (ref) => create(ref as UndoDislikeCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
        cardId: cardId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UndoDislikeCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UndoDislikeCardProvider &&
        other.sessionId == sessionId &&
        other.cardId == cardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UndoDislikeCardRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;

  /// The parameter `cardId` of this provider.
  String get cardId;
}

class _UndoDislikeCardProviderElement
    extends AutoDisposeFutureProviderElement<void> with UndoDislikeCardRef {
  _UndoDislikeCardProviderElement(super.provider);

  @override
  String get sessionId => (origin as UndoDislikeCardProvider).sessionId;
  @override
  String get cardId => (origin as UndoDislikeCardProvider).cardId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
