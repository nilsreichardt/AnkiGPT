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

  /// The information of the job that created this card.
  ///
  /// This feature was added on 8. August 2023. Cards created before that
  /// date will have a null value for this field.
  Job? get job => throw _privateConstructorUsedError;

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
      bool hasDisliked,
      Job? job});

  $JobCopyWith<$Res>? get job;
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
    Object? job = freezed,
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
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JobCopyWith<$Res>? get job {
    if (_value.job == null) {
      return null;
    }

    return $JobCopyWith<$Res>(_value.job!, (value) {
      return _then(_value.copyWith(job: value) as $Val);
    });
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
      bool hasDisliked,
      Job? job});

  @override
  $JobCopyWith<$Res>? get job;
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
    Object? job = freezed,
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
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnkiCard extends _AnkiCard {
  const _$_AnkiCard(
      {required this.id,
      required this.question,
      required this.answer,
      @JsonKey(fromJson: parseTimestampOrIsoString) required this.createdAt,
      this.hasLiked = false,
      this.hasDisliked = false,
      this.job})
      : super._();

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

  /// The information of the job that created this card.
  ///
  /// This feature was added on 8. August 2023. Cards created before that
  /// date will have a null value for this field.
  @override
  final Job? job;

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
                other.hasDisliked == hasDisliked) &&
            (identical(other.job, job) || other.job == job));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, question, answer, createdAt, hasLiked, hasDisliked, job);

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

abstract class _AnkiCard extends AnkiCard {
  const factory _AnkiCard(
      {required final String id,
      required final String question,
      required final String answer,
      @JsonKey(fromJson: parseTimestampOrIsoString)
          required final DateTime createdAt,
      final bool hasLiked,
      final bool hasDisliked,
      final Job? job}) = _$_AnkiCard;
  const _AnkiCard._() : super._();

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

  /// The information of the job that created this card.
  ///
  /// This feature was added on 8. August 2023. Cards created before that
  /// date will have a null value for this field.
  Job? get job;
  @override
  @JsonKey(ignore: true)
  _$$_AnkiCardCopyWith<_$_AnkiCard> get copyWith =>
      throw _privateConstructorUsedError;
}

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call({String id, int index});
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$_JobCopyWith(_$_Job value, $Res Function(_$_Job) then) =
      __$$_JobCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int index});
}

/// @nodoc
class __$$_JobCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$_Job>
    implements _$$_JobCopyWith<$Res> {
  __$$_JobCopyWithImpl(_$_Job _value, $Res Function(_$_Job) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = null,
  }) {
    return _then(_$_Job(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Job implements _Job {
  const _$_Job({required this.id, required this.index});

  factory _$_Job.fromJson(Map<String, dynamic> json) => _$$_JobFromJson(json);

  @override
  final String id;
  @override
  final int index;

  @override
  String toString() {
    return 'Job(id: $id, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Job &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobCopyWith<_$_Job> get copyWith =>
      __$$_JobCopyWithImpl<_$_Job>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobToJson(
      this,
    );
  }
}

abstract class _Job implements Job {
  const factory _Job({required final String id, required final int index}) =
      _$_Job;

  factory _Job.fromJson(Map<String, dynamic> json) = _$_Job.fromJson;

  @override
  String get id;
  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$_JobCopyWith<_$_Job> get copyWith => throw _privateConstructorUsedError;
}
