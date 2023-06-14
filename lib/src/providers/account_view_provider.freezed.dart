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
  String? get email => throw _privateConstructorUsedError;
  AuthProvider get authProvider => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountViewCopyWith<AccountView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountViewCopyWith<$Res> {
  factory $AccountViewCopyWith(
          AccountView value, $Res Function(AccountView) then) =
      _$AccountViewCopyWithImpl<$Res, AccountView>;
  @useResult
  $Res call({String? email, AuthProvider authProvider});
}

/// @nodoc
class _$AccountViewCopyWithImpl<$Res, $Val extends AccountView>
    implements $AccountViewCopyWith<$Res> {
  _$AccountViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? authProvider = null,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      authProvider: null == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as AuthProvider,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountViewCopyWith<$Res>
    implements $AccountViewCopyWith<$Res> {
  factory _$$_AccountViewCopyWith(
          _$_AccountView value, $Res Function(_$_AccountView) then) =
      __$$_AccountViewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, AuthProvider authProvider});
}

/// @nodoc
class __$$_AccountViewCopyWithImpl<$Res>
    extends _$AccountViewCopyWithImpl<$Res, _$_AccountView>
    implements _$$_AccountViewCopyWith<$Res> {
  __$$_AccountViewCopyWithImpl(
      _$_AccountView _value, $Res Function(_$_AccountView) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? authProvider = null,
  }) {
    return _then(_$_AccountView(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      authProvider: null == authProvider
          ? _value.authProvider
          : authProvider // ignore: cast_nullable_to_non_nullable
              as AuthProvider,
    ));
  }
}

/// @nodoc

class _$_AccountView implements _AccountView {
  const _$_AccountView({this.email, required this.authProvider});

  @override
  final String? email;
  @override
  final AuthProvider authProvider;

  @override
  String toString() {
    return 'AccountView(email: $email, authProvider: $authProvider)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountView &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.authProvider, authProvider) ||
                other.authProvider == authProvider));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, authProvider);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountViewCopyWith<_$_AccountView> get copyWith =>
      __$$_AccountViewCopyWithImpl<_$_AccountView>(this, _$identity);
}

abstract class _AccountView implements AccountView {
  const factory _AccountView(
      {final String? email,
      required final AuthProvider authProvider}) = _$_AccountView;

  @override
  String? get email;
  @override
  AuthProvider get authProvider;
  @override
  @JsonKey(ignore: true)
  _$$_AccountViewCopyWith<_$_AccountView> get copyWith =>
      throw _privateConstructorUsedError;
}
