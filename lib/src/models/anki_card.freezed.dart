// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anki_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AnkiCard {
  String get front => throw _privateConstructorUsedError;
  String get back => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AnkiCardCopyWith<AnkiCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnkiCardCopyWith<$Res> {
  factory $AnkiCardCopyWith(AnkiCard value, $Res Function(AnkiCard) then) =
      _$AnkiCardCopyWithImpl<$Res, AnkiCard>;
  @useResult
  $Res call({String front, String back});
}

/// @nodoc
class _$AnkiCardCopyWithImpl<$Res, $Val extends AnkiCard>
    implements $AnkiCardCopyWith<$Res> {
  _$AnkiCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? front = null,
    Object? back = null,
  }) {
    return _then(_value.copyWith(
      front: null == front
          ? _value.front
          : front // ignore: cast_nullable_to_non_nullable
              as String,
      back: null == back
          ? _value.back
          : back // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnkiCardCopyWith<$Res> implements $AnkiCardCopyWith<$Res> {
  factory _$$_AnkiCardCopyWith(
          _$_AnkiCard value, $Res Function(_$_AnkiCard) then) =
      __$$_AnkiCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String front, String back});
}

/// @nodoc
class __$$_AnkiCardCopyWithImpl<$Res>
    extends _$AnkiCardCopyWithImpl<$Res, _$_AnkiCard>
    implements _$$_AnkiCardCopyWith<$Res> {
  __$$_AnkiCardCopyWithImpl(
      _$_AnkiCard _value, $Res Function(_$_AnkiCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? front = null,
    Object? back = null,
  }) {
    return _then(_$_AnkiCard(
      front: null == front
          ? _value.front
          : front // ignore: cast_nullable_to_non_nullable
              as String,
      back: null == back
          ? _value.back
          : back // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AnkiCard implements _AnkiCard {
  const _$_AnkiCard({required this.front, required this.back});

  @override
  final String front;
  @override
  final String back;

  @override
  String toString() {
    return 'AnkiCard(front: $front, back: $back)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnkiCard &&
            (identical(other.front, front) || other.front == front) &&
            (identical(other.back, back) || other.back == back));
  }

  @override
  int get hashCode => Object.hash(runtimeType, front, back);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnkiCardCopyWith<_$_AnkiCard> get copyWith =>
      __$$_AnkiCardCopyWithImpl<_$_AnkiCard>(this, _$identity);
}

abstract class _AnkiCard implements AnkiCard {
  const factory _AnkiCard(
      {required final String front, required final String back}) = _$_AnkiCard;

  @override
  String get front;
  @override
  String get back;
  @override
  @JsonKey(ignore: true)
  _$$_AnkiCardCopyWith<_$_AnkiCard> get copyWith =>
      throw _privateConstructorUsedError;
}