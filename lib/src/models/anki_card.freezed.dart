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

AnkiCard _$AnkiCardFromJson(Map<String, dynamic> json) {
  return _AnkiCard.fromJson(json);
}

/// @nodoc
mixin _$AnkiCard {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseTimestampOrIsoString)
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get hasLiked => throw _privateConstructorUsedError;
  bool get hasDisliked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnkiCardCopyWith<AnkiCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnkiCardCopyWith<$Res> {
  factory $AnkiCardCopyWith(AnkiCard value, $Res Function(AnkiCard) then) =
      _$AnkiCardCopyWithImpl<$Res, AnkiCard>;
  @useResult
  $Res call(
      {String id,
      String question,
      String answer,
      @JsonKey(fromJson: parseTimestampOrIsoString) DateTime createdAt,
      bool hasLiked,
      bool hasDisliked});
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
    Object? id = null,
    Object? question = null,
    Object? answer = null,
    Object? createdAt = null,
    Object? hasLiked = null,
    Object? hasDisliked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasLiked: null == hasLiked
          ? _value.hasLiked
          : hasLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDisliked: null == hasDisliked
          ? _value.hasDisliked
          : hasDisliked // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call(
      {String id,
      String question,
      String answer,
      @JsonKey(fromJson: parseTimestampOrIsoString) DateTime createdAt,
      bool hasLiked,
      bool hasDisliked});
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
    Object? id = null,
    Object? question = null,
    Object? answer = null,
    Object? createdAt = null,
    Object? hasLiked = null,
    Object? hasDisliked = null,
  }) {
    return _then(_$_AnkiCard(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hasLiked: null == hasLiked
          ? _value.hasLiked
          : hasLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDisliked: null == hasDisliked
          ? _value.hasDisliked
          : hasDisliked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnkiCard implements _AnkiCard {
  const _$_AnkiCard(
      {required this.id,
      required this.question,
      required this.answer,
      @JsonKey(fromJson: parseTimestampOrIsoString) required this.createdAt,
      this.hasLiked = false,
      this.hasDisliked = false});

  factory _$_AnkiCard.fromJson(Map<String, dynamic> json) =>
      _$$_AnkiCardFromJson(json);

  @override
  final String id;
  @override
  final String question;
  @override
  final String answer;
  @override
  @JsonKey(fromJson: parseTimestampOrIsoString)
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool hasLiked;
  @override
  @JsonKey()
  final bool hasDisliked;

  @override
  String toString() {
    return 'AnkiCard(id: $id, question: $question, answer: $answer, createdAt: $createdAt, hasLiked: $hasLiked, hasDisliked: $hasDisliked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnkiCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.hasLiked, hasLiked) ||
                other.hasLiked == hasLiked) &&
            (identical(other.hasDisliked, hasDisliked) ||
                other.hasDisliked == hasDisliked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, question, answer, createdAt, hasLiked, hasDisliked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnkiCardCopyWith<_$_AnkiCard> get copyWith =>
      __$$_AnkiCardCopyWithImpl<_$_AnkiCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnkiCardToJson(
      this,
    );
  }
}

abstract class _AnkiCard implements AnkiCard {
  const factory _AnkiCard(
      {required final String id,
      required final String question,
      required final String answer,
      @JsonKey(fromJson: parseTimestampOrIsoString)
          required final DateTime createdAt,
      final bool hasLiked,
      final bool hasDisliked}) = _$_AnkiCard;

  factory _AnkiCard.fromJson(Map<String, dynamic> json) = _$_AnkiCard.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  String get answer;
  @override
  @JsonKey(fromJson: parseTimestampOrIsoString)
  DateTime get createdAt;
  @override
  bool get hasLiked;
  @override
  bool get hasDisliked;
  @override
  @JsonKey(ignore: true)
  _$$_AnkiCardCopyWith<_$_AnkiCard> get copyWith =>
      throw _privateConstructorUsedError;
}
