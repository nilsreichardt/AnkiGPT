// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$watchHash() => r'116f2230137cf8d8739de90a5652cbb63739f75d';

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

abstract class _$Watch extends BuildlessAutoDisposeNotifier<WatchView> {
  late final String sessionId;

  WatchView build(
    String sessionId,
  );
}

/// See also [Watch].
@ProviderFor(Watch)
const watchProvider = WatchFamily();

/// See also [Watch].
class WatchFamily extends Family<WatchView> {
  /// See also [Watch].
  const WatchFamily();

  /// See also [Watch].
  WatchProvider call(
    String sessionId,
  ) {
    return WatchProvider(
      sessionId,
    );
  }

  @override
  WatchProvider getProviderOverride(
    covariant WatchProvider provider,
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
  String? get name => r'watchProvider';
}

/// See also [Watch].
class WatchProvider extends AutoDisposeNotifierProviderImpl<Watch, WatchView> {
  /// See also [Watch].
  WatchProvider(
    this.sessionId,
  ) : super.internal(
          () => Watch()..sessionId = sessionId,
          from: watchProvider,
          name: r'watchProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchHash,
          dependencies: WatchFamily._dependencies,
          allTransitiveDependencies: WatchFamily._allTransitiveDependencies,
        );

  final String sessionId;

  @override
  bool operator ==(Object other) {
    return other is WatchProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  WatchView runNotifierBuild(
    covariant Watch notifier,
  ) {
    return notifier.build(
      sessionId,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
