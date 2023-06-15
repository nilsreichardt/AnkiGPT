// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deleteQueueHash() => r'3b8fe8938f05d607e8917ffbcb55a2c6b0618266';

/// See also [deleteQueue].
@ProviderFor(deleteQueue)
final deleteQueueProvider = Provider<Queue>.internal(
  deleteQueue,
  name: r'deleteQueueProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deleteQueueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteQueueRef = ProviderRef<Queue>;
String _$deleteCardHash() => r'2e55ce1c3d9405441b29bbb28cbdd77758faa50a';

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

typedef DeleteCardRef = AutoDisposeProviderRef<void>;

/// See also [deleteCard].
@ProviderFor(deleteCard)
const deleteCardProvider = DeleteCardFamily();

/// See also [deleteCard].
class DeleteCardFamily extends Family<void> {
  /// See also [deleteCard].
  const DeleteCardFamily();

  /// See also [deleteCard].
  DeleteCardProvider call({
    required String cardId,
    required String sessionId,
  }) {
    return DeleteCardProvider(
      cardId: cardId,
      sessionId: sessionId,
    );
  }

  @override
  DeleteCardProvider getProviderOverride(
    covariant DeleteCardProvider provider,
  ) {
    return call(
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
  String? get name => r'deleteCardProvider';
}

/// See also [deleteCard].
class DeleteCardProvider extends AutoDisposeProvider<void> {
  /// See also [deleteCard].
  DeleteCardProvider({
    required this.cardId,
    required this.sessionId,
  }) : super.internal(
          (ref) => deleteCard(
            ref,
            cardId: cardId,
            sessionId: sessionId,
          ),
          from: deleteCardProvider,
          name: r'deleteCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteCardHash,
          dependencies: DeleteCardFamily._dependencies,
          allTransitiveDependencies:
              DeleteCardFamily._allTransitiveDependencies,
        );

  final String cardId;
  final String sessionId;

  @override
  bool operator ==(Object other) {
    return other is DeleteCardProvider &&
        other.cardId == cardId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$undoDeleteCardHash() => r'c5ef35f0553b0ea174d0e7b42e3845bc07cb7955';
typedef UndoDeleteCardRef = AutoDisposeProviderRef<void>;

/// See also [undoDeleteCard].
@ProviderFor(undoDeleteCard)
const undoDeleteCardProvider = UndoDeleteCardFamily();

/// See also [undoDeleteCard].
class UndoDeleteCardFamily extends Family<void> {
  /// See also [undoDeleteCard].
  const UndoDeleteCardFamily();

  /// See also [undoDeleteCard].
  UndoDeleteCardProvider call({
    required String cardId,
    required String sessionId,
  }) {
    return UndoDeleteCardProvider(
      cardId: cardId,
      sessionId: sessionId,
    );
  }

  @override
  UndoDeleteCardProvider getProviderOverride(
    covariant UndoDeleteCardProvider provider,
  ) {
    return call(
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
  String? get name => r'undoDeleteCardProvider';
}

/// See also [undoDeleteCard].
class UndoDeleteCardProvider extends AutoDisposeProvider<void> {
  /// See also [undoDeleteCard].
  UndoDeleteCardProvider({
    required this.cardId,
    required this.sessionId,
  }) : super.internal(
          (ref) => undoDeleteCard(
            ref,
            cardId: cardId,
            sessionId: sessionId,
          ),
          from: undoDeleteCardProvider,
          name: r'undoDeleteCardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$undoDeleteCardHash,
          dependencies: UndoDeleteCardFamily._dependencies,
          allTransitiveDependencies:
              UndoDeleteCardFamily._allTransitiveDependencies,
        );

  final String cardId;
  final String sessionId;

  @override
  bool operator ==(Object other) {
    return other is UndoDeleteCardProvider &&
        other.cardId == cardId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cardId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
