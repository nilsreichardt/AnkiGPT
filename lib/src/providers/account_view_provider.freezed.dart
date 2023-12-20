// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_view_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountView {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)
        signedIn,
    required TResult Function() signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult? Function()? signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult Function()? signedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountViewSignedIn value) signedIn,
    required TResult Function(AccountViewSignedOut value) signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountViewSignedIn value)? signedIn,
    TResult? Function(AccountViewSignedOut value)? signedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountViewSignedIn value)? signedIn,
    TResult Function(AccountViewSignedOut value)? signedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountViewCopyWith<$Res> {
  factory $AccountViewCopyWith(
          AccountView value, $Res Function(AccountView) then) =
      _$AccountViewCopyWithImpl<$Res, AccountView>;
}

/// @nodoc
class _$AccountViewCopyWithImpl<$Res, $Val extends AccountView>
    implements $AccountViewCopyWith<$Res> {
  _$AccountViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AccountViewSignedInCopyWith<$Res> {
  factory _$$AccountViewSignedInCopyWith(_$AccountViewSignedIn value,
          $Res Function(_$AccountViewSignedIn) then) =
      __$$AccountViewSignedInCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? email,
      AuthProvider authProvider,
      int generatedCardsCurrentMonth,
      int generatedMnemonicsCurrentMonth,
      bool hasPlus});
}

/// @nodoc
class __$$AccountViewSignedInCopyWithImpl<$Res>
    extends _$AccountViewCopyWithImpl<$Res, _$AccountViewSignedIn>
    implements _$$AccountViewSignedInCopyWith<$Res> {
  __$$AccountViewSignedInCopyWithImpl(
      _$AccountViewSignedIn _value, $Res Function(_$AccountViewSignedIn) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? authProvider = null,
    Object? generatedCardsCurrentMonth = null,
    Object? generatedMnemonicsCurrentMonth = null,
    Object? hasPlus = null,
  }) {
    return _then(_$AccountViewSignedIn(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      authProvider: null == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as AuthProvider,
      generatedCardsCurrentMonth: null == generatedCardsCurrentMonth
          ? _value.generatedCardsCurrentMonth
          : generatedCardsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      generatedMnemonicsCurrentMonth: null == generatedMnemonicsCurrentMonth
          ? _value.generatedMnemonicsCurrentMonth
          : generatedMnemonicsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      hasPlus: null == hasPlus
          ? _value.hasPlus
          : hasPlus // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AccountViewSignedIn implements AccountViewSignedIn {
  const _$AccountViewSignedIn(
      {this.email,
      required this.authProvider,
      required this.generatedCardsCurrentMonth,
      required this.generatedMnemonicsCurrentMonth,
      required this.hasPlus});

  @override
  final String? email;
  @override
  final AuthProvider authProvider;
  @override
  final int generatedCardsCurrentMonth;
  @override
  final int generatedMnemonicsCurrentMonth;
  @override
  final bool hasPlus;

  @override
  String toString() {
    return 'AccountView.signedIn(email: $email, authProvider: $authProvider, generatedCardsCurrentMonth: $generatedCardsCurrentMonth, generatedMnemonicsCurrentMonth: $generatedMnemonicsCurrentMonth, hasPlus: $hasPlus)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountViewSignedIn &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.authProvider, authProvider) ||
                other.authProvider == authProvider) &&
            (identical(other.generatedCardsCurrentMonth,
                    generatedCardsCurrentMonth) ||
                other.generatedCardsCurrentMonth ==
                    generatedCardsCurrentMonth) &&
            (identical(other.generatedMnemonicsCurrentMonth,
                    generatedMnemonicsCurrentMonth) ||
                other.generatedMnemonicsCurrentMonth ==
                    generatedMnemonicsCurrentMonth) &&
            (identical(other.hasPlus, hasPlus) || other.hasPlus == hasPlus));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, authProvider,
      generatedCardsCurrentMonth, generatedMnemonicsCurrentMonth, hasPlus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountViewSignedInCopyWith<_$AccountViewSignedIn> get copyWith =>
      __$$AccountViewSignedInCopyWithImpl<_$AccountViewSignedIn>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)
        signedIn,
    required TResult Function() signedOut,
  }) {
    return signedIn(email, authProvider, generatedCardsCurrentMonth,
        generatedMnemonicsCurrentMonth, hasPlus);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult? Function()? signedOut,
  }) {
    return signedIn?.call(email, authProvider, generatedCardsCurrentMonth,
        generatedMnemonicsCurrentMonth, hasPlus);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult Function()? signedOut,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(email, authProvider, generatedCardsCurrentMonth,
          generatedMnemonicsCurrentMonth, hasPlus);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountViewSignedIn value) signedIn,
    required TResult Function(AccountViewSignedOut value) signedOut,
  }) {
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountViewSignedIn value)? signedIn,
    TResult? Function(AccountViewSignedOut value)? signedOut,
  }) {
    return signedIn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountViewSignedIn value)? signedIn,
    TResult Function(AccountViewSignedOut value)? signedOut,
    required TResult orElse(),
  }) {
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class AccountViewSignedIn implements AccountView {
  const factory AccountViewSignedIn(
      {final String? email,
      required final AuthProvider authProvider,
      required final int generatedCardsCurrentMonth,
      required final int generatedMnemonicsCurrentMonth,
      required final bool hasPlus}) = _$AccountViewSignedIn;

  String? get email;
  AuthProvider get authProvider;
  int get generatedCardsCurrentMonth;
  int get generatedMnemonicsCurrentMonth;
  bool get hasPlus;
  @JsonKey(ignore: true)
  _$$AccountViewSignedInCopyWith<_$AccountViewSignedIn> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountViewSignedOutCopyWith<$Res> {
  factory _$$AccountViewSignedOutCopyWith(_$AccountViewSignedOut value,
          $Res Function(_$AccountViewSignedOut) then) =
      __$$AccountViewSignedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountViewSignedOutCopyWithImpl<$Res>
    extends _$AccountViewCopyWithImpl<$Res, _$AccountViewSignedOut>
    implements _$$AccountViewSignedOutCopyWith<$Res> {
  __$$AccountViewSignedOutCopyWithImpl(_$AccountViewSignedOut _value,
      $Res Function(_$AccountViewSignedOut) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AccountViewSignedOut implements AccountViewSignedOut {
  const _$AccountViewSignedOut();

  @override
  String toString() {
    return 'AccountView.signedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountViewSignedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)
        signedIn,
    required TResult Function() signedOut,
  }) {
    return signedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult? Function()? signedOut,
  }) {
    return signedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String? email,
            AuthProvider authProvider,
            int generatedCardsCurrentMonth,
            int generatedMnemonicsCurrentMonth,
            bool hasPlus)?
        signedIn,
    TResult Function()? signedOut,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountViewSignedIn value) signedIn,
    required TResult Function(AccountViewSignedOut value) signedOut,
  }) {
    return signedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountViewSignedIn value)? signedIn,
    TResult? Function(AccountViewSignedOut value)? signedOut,
  }) {
    return signedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountViewSignedIn value)? signedIn,
    TResult Function(AccountViewSignedOut value)? signedOut,
    required TResult orElse(),
  }) {
    if (signedOut != null) {
      return signedOut(this);
    }
    return orElse();
  }
}

abstract class AccountViewSignedOut implements AccountView {
  const factory AccountViewSignedOut() = _$AccountViewSignedOut;
}
