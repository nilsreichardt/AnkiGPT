// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likeCardHash() => r'31454571e043aa4bde09fb563a794cb2d30d3139';

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

typedef LikeCardRef = AutoDisposeFutureProviderRef<void>;

/// See also [likeCard].
@ProviderFor(likeCard)
const likeCardProvider = LikeCardFamily();

/// See also [likeCard].
class LikeCardFamily extends Family<AsyncValue<void>> {
  /// See also [likeCard].
  const LikeCardFamily();

  /// See also [likeCard].
  LikeCardProvider call({
    required String sessionId,
    required String cardId,
    String? text,
  }) {
    return LikeCardProvider(
      sessionId: sessionId,
      cardId: cardId,
      text: text,
    );
  }

  @override
  LikeCardProvider getProviderOverride(
    covariant LikeCardProvider provider,
  ) {
    return call(
      sessionId: provider.sessionId,
      cardId: provider.cardId,
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
  String? get name => r'likeCardProvider';
}

/// See also [likeCard].
class LikeCardProvider extends AutoDisposeFutureProvider<void> {
  /// See also [likeCard].
  LikeCardProvider({
    required this.sessionId,
    required this.cardId,
    this.text,
  }) : super.internal(
          (ref) => likeCard(
            ref,
            sessionId: sessionId,
            cardId: cardId,
            text: text,
          ),
          from: likeCardProvider,
          name: r'likeCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likeCardHash,
          dependencies: LikeCardFamily._dependencies,
          allTransitiveDependencies: LikeCardFamily._allTransitiveDependencies,
        );

  final String sessionId;
  final String cardId;
  final String? text;

  @override
  bool operator ==(Object other) {
    return other is LikeCardProvider &&
        other.sessionId == sessionId &&
        other.cardId == cardId &&
        other.text == text;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, text.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$undoLikeCardHash() => r'de3bb095eaaf29f47b13041d2b82dc45bab93a8f';
typedef UndoLikeCardRef = AutoDisposeFutureProviderRef<void>;

/// See also [undoLikeCard].
@ProviderFor(undoLikeCard)
const undoLikeCardProvider = UndoLikeCardFamily();

/// See also [undoLikeCard].
class UndoLikeCardFamily extends Family<AsyncValue<void>> {
  /// See also [undoLikeCard].
  const UndoLikeCardFamily();

  /// See also [undoLikeCard].
  UndoLikeCardProvider call({
    required String sessionId,
    required String cardId,
  }) {
    return UndoLikeCardProvider(
      sessionId: sessionId,
      cardId: cardId,
    );
  }

  @override
  UndoLikeCardProvider getProviderOverride(
    covariant UndoLikeCardProvider provider,
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
  String? get name => r'undoLikeCardProvider';
}

/// See also [undoLikeCard].
class UndoLikeCardProvider extends AutoDisposeFutureProvider<void> {
  /// See also [undoLikeCard].
  UndoLikeCardProvider({
    required this.sessionId,
    required this.cardId,
  }) : super.internal(
          (ref) => undoLikeCard(
            ref,
            sessionId: sessionId,
            cardId: cardId,
          ),
          from: undoLikeCardProvider,
          name: r'undoLikeCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$undoLikeCardHash,
          dependencies: UndoLikeCardFamily._dependencies,
          allTransitiveDependencies:
              UndoLikeCardFamily._allTransitiveDependencies,
        );

  final String sessionId;
  final String cardId;

  @override
  bool operator ==(Object other) {
    return other is UndoLikeCardProvider &&
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
