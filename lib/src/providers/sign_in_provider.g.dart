// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInHash() => r'79c7d78df13b9e6a600abd96a1ee842de6b108cf';

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

/// See also [signIn].
@ProviderFor(signIn)
const signInProvider = SignInFamily();

/// See also [signIn].
class SignInFamily extends Family<AsyncValue<void>> {
  /// See also [signIn].
  const SignInFamily();

  /// See also [signIn].
  SignInProvider call({
    required AuthProvider authProvider,
  }) {
    return SignInProvider(
      authProvider: authProvider,
    );
  }

  @override
  SignInProvider getProviderOverride(
    covariant SignInProvider provider,
  ) {
    return call(
      authProvider: provider.authProvider,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    generateNotifierProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    generateNotifierProvider,
    ...?generateNotifierProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'signInProvider';
}

/// See also [signIn].
class SignInProvider extends AutoDisposeFutureProvider<void> {
  /// See also [signIn].
  SignInProvider({
    required AuthProvider authProvider,
  }) : this._internal(
          (ref) => signIn(
            ref as SignInRef,
            authProvider: authProvider,
          ),
          from: signInProvider,
          name: r'signInProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signInHash,
          dependencies: SignInFamily._dependencies,
          allTransitiveDependencies: SignInFamily._allTransitiveDependencies,
          authProvider: authProvider,
        );

  SignInProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authProvider,
  }) : super.internal();

  final AuthProvider authProvider;

  @override
  Override overrideWith(
    FutureOr<void> Function(SignInRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignInProvider._internal(
        (ref) => create(ref as SignInRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authProvider: authProvider,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SignInProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignInProvider && other.authProvider == authProvider;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authProvider.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SignInRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `authProvider` of this provider.
  AuthProvider get authProvider;
}

class _SignInProviderElement extends AutoDisposeFutureProviderElement<void>
    with SignInRef {
  _SignInProviderElement(super.provider);

  @override
  AuthProvider get authProvider => (origin as SignInProvider).authProvider;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
