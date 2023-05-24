// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_cards_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetCardsResponse _$GetCardsResponseFromJson(Map<String, dynamic> json) {
  return _GetCardsResponse.fromJson(json);
}

/// @nodoc
mixin _$GetCardsResponse {
  List<AnkiCard> get cards => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetCardsResponseCopyWith<GetCardsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCardsResponseCopyWith<$Res> {
  factory $GetCardsResponseCopyWith(
          GetCardsResponse value, $Res Function(GetCardsResponse) then) =
      _$GetCardsResponseCopyWithImpl<$Res, GetCardsResponse>;
  @useResult
  $Res call({List<AnkiCard> cards, bool isCompleted, String? error});
}

/// @nodoc
class _$GetCardsResponseCopyWithImpl<$Res, $Val extends GetCardsResponse>
    implements $GetCardsResponseCopyWith<$Res> {
  _$GetCardsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? isCompleted = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetCardsResponseCopyWith<$Res>
    implements $GetCardsResponseCopyWith<$Res> {
  factory _$$_GetCardsResponseCopyWith(
          _$_GetCardsResponse value, $Res Function(_$_GetCardsResponse) then) =
      __$$_GetCardsResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AnkiCard> cards, bool isCompleted, String? error});
}

/// @nodoc
class __$$_GetCardsResponseCopyWithImpl<$Res>
    extends _$GetCardsResponseCopyWithImpl<$Res, _$_GetCardsResponse>
    implements _$$_GetCardsResponseCopyWith<$Res> {
  __$$_GetCardsResponseCopyWithImpl(
      _$_GetCardsResponse _value, $Res Function(_$_GetCardsResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? isCompleted = null,
    Object? error = freezed,
  }) {
    return _then(_$_GetCardsResponse(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetCardsResponse implements _GetCardsResponse {
  const _$_GetCardsResponse(
      {required final List<AnkiCard> cards,
      required this.isCompleted,
      this.error})
      : _cards = cards;

  factory _$_GetCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetCardsResponseFromJson(json);

  final List<AnkiCard> _cards;
  @override
  List<AnkiCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final bool isCompleted;
  @override
  final String? error;

  @override
  String toString() {
    return 'GetCardsResponse(cards: $cards, isCompleted: $isCompleted, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetCardsResponse &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_cards), isCompleted, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetCardsResponseCopyWith<_$_GetCardsResponse> get copyWith =>
      __$$_GetCardsResponseCopyWithImpl<_$_GetCardsResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetCardsResponseToJson(
      this,
    );
  }
}

abstract class _GetCardsResponse implements GetCardsResponse {
  const factory _GetCardsResponse(
      {required final List<AnkiCard> cards,
      required final bool isCompleted,
      final String? error}) = _$_GetCardsResponse;

  factory _GetCardsResponse.fromJson(Map<String, dynamic> json) =
      _$_GetCardsResponse.fromJson;

  @override
  List<AnkiCard> get cards;
  @override
  bool get isCompleted;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$_GetCardsResponseCopyWith<_$_GetCardsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
