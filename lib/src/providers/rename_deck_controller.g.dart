// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rename_deck_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$renameDeckControllerHash() =>
    r'40da58b826355664c82cfe8459d21b4587cf712b';

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

abstract class _$RenameDeckController
    extends BuildlessAutoDisposeNotifier<RenameDeckState> {
  late final String sessionId;

  RenameDeckState build(
    String sessionId,
  );
}

/// See also [RenameDeckController].
@ProviderFor(RenameDeckController)
const renameDeckControllerProvider = RenameDeckControllerFamily();

/// See also [RenameDeckController].
class RenameDeckControllerFamily extends Family<RenameDeckState> {
  /// See also [RenameDeckController].
  const RenameDeckControllerFamily();

  /// See also [RenameDeckController].
  RenameDeckControllerProvider call(
    String sessionId,
  ) {
    return RenameDeckControllerProvider(
      sessionId,
    );
  }

  @override
  RenameDeckControllerProvider getProviderOverride(
    covariant RenameDeckControllerProvider provider,
  ) {
    return call(
      provider.sessionId,
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
  String? get name => r'renameDeckControllerProvider';
}

/// See also [RenameDeckController].
class RenameDeckControllerProvider extends AutoDisposeNotifierProviderImpl<
    RenameDeckController, RenameDeckState> {
  /// See also [RenameDeckController].
  RenameDeckControllerProvider(
    String sessionId,
  ) : this._internal(
          () => RenameDeckController()..sessionId = sessionId,
          from: renameDeckControllerProvider,
          name: r'renameDeckControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$renameDeckControllerHash,
          dependencies: RenameDeckControllerFamily._dependencies,
          allTransitiveDependencies:
              RenameDeckControllerFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  RenameDeckControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  RenameDeckState runNotifierBuild(
    covariant RenameDeckController notifier,
  ) {
    return notifier.build(
      sessionId,
    );
  }

  @override
  Override overrideWith(RenameDeckController Function() create) {
    return ProviderOverride(
      origin: this,
      override: RenameDeckControllerProvider._internal(
        () => create()..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RenameDeckController, RenameDeckState>
      createElement() {
    return _RenameDeckControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RenameDeckControllerProvider &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RenameDeckControllerRef
    on AutoDisposeNotifierProviderRef<RenameDeckState> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _RenameDeckControllerProviderElement
    extends AutoDisposeNotifierProviderElement<RenameDeckController,
        RenameDeckState> with RenameDeckControllerRef {
  _RenameDeckControllerProviderElement(super.provider);

  @override
  String get sessionId => (origin as RenameDeckControllerProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
