// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HistoryDeck {
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get numberOfCards => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, SessionDto sessionDto, int numberOfCards)
        created,
    required TResult Function(
            DateTime createdAt, String name, int numberOfCards)
        loading,
    required TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult? Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryDeckCreated value) created,
    required TResult Function(HistoryDeckLoading value) loading,
    required TResult Function(HistoryDeckError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryDeckCreated value)? created,
    TResult? Function(HistoryDeckLoading value)? loading,
    TResult? Function(HistoryDeckError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryDeckCreated value)? created,
    TResult Function(HistoryDeckLoading value)? loading,
    TResult Function(HistoryDeckError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryDeckCopyWith<HistoryDeck> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryDeckCopyWith<$Res> {
  factory $HistoryDeckCopyWith(
          HistoryDeck value, $Res Function(HistoryDeck) then) =
      _$HistoryDeckCopyWithImpl<$Res, HistoryDeck>;
  @useResult
  $Res call({DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class _$HistoryDeckCopyWithImpl<$Res, $Val extends HistoryDeck>
    implements $HistoryDeckCopyWith<$Res> {
  _$HistoryDeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryDeckCreatedCopyWith<$Res>
    implements $HistoryDeckCopyWith<$Res> {
  factory _$$HistoryDeckCreatedCopyWith(_$HistoryDeckCreated value,
          $Res Function(_$HistoryDeckCreated) then) =
      __$$HistoryDeckCreatedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> questions,
      DateTime createdAt,
      String name,
      SessionDto sessionDto,
      int numberOfCards});

  $SessionDtoCopyWith<$Res> get sessionDto;
}

/// @nodoc
class __$$HistoryDeckCreatedCopyWithImpl<$Res>
    extends _$HistoryDeckCopyWithImpl<$Res, _$HistoryDeckCreated>
    implements _$$HistoryDeckCreatedCopyWith<$Res> {
  __$$HistoryDeckCreatedCopyWithImpl(
      _$HistoryDeckCreated _value, $Res Function(_$HistoryDeckCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? createdAt = null,
    Object? name = null,
    Object? sessionDto = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$HistoryDeckCreated(
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sessionDto: null == sessionDto
          ? _value.sessionDto
          : sessionDto // ignore: cast_nullable_to_non_nullable
              as SessionDto,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SessionDtoCopyWith<$Res> get sessionDto {
    return $SessionDtoCopyWith<$Res>(_value.sessionDto, (value) {
      return _then(_value.copyWith(sessionDto: value));
    });
  }
}

/// @nodoc

class _$HistoryDeckCreated implements HistoryDeckCreated {
  const _$HistoryDeckCreated(
      {required final List<String> questions,
      required this.createdAt,
      required this.name,
      required this.sessionDto,
      required this.numberOfCards})
      : _questions = questions;

  final List<String> _questions;
  @override
  List<String> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final SessionDto sessionDto;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'HistoryDeck.created(questions: $questions, createdAt: $createdAt, name: $name, sessionDto: $sessionDto, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryDeckCreated &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sessionDto, sessionDto) ||
                other.sessionDto == sessionDto) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_questions),
      createdAt,
      name,
      sessionDto,
      numberOfCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryDeckCreatedCopyWith<_$HistoryDeckCreated> get copyWith =>
      __$$HistoryDeckCreatedCopyWithImpl<_$HistoryDeckCreated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, SessionDto sessionDto, int numberOfCards)
        created,
    required TResult Function(
            DateTime createdAt, String name, int numberOfCards)
        loading,
    required TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)
        error,
  }) {
    return created(questions, createdAt, name, sessionDto, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult? Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
  }) {
    return created?.call(questions, createdAt, name, sessionDto, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(questions, createdAt, name, sessionDto, numberOfCards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryDeckCreated value) created,
    required TResult Function(HistoryDeckLoading value) loading,
    required TResult Function(HistoryDeckError value) error,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryDeckCreated value)? created,
    TResult? Function(HistoryDeckLoading value)? loading,
    TResult? Function(HistoryDeckError value)? error,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryDeckCreated value)? created,
    TResult Function(HistoryDeckLoading value)? loading,
    TResult Function(HistoryDeckError value)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class HistoryDeckCreated implements HistoryDeck {
  const factory HistoryDeckCreated(
      {required final List<String> questions,
      required final DateTime createdAt,
      required final String name,
      required final SessionDto sessionDto,
      required final int numberOfCards}) = _$HistoryDeckCreated;

  List<String> get questions;
  @override
  DateTime get createdAt;
  @override
  String get name;
  SessionDto get sessionDto;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$HistoryDeckCreatedCopyWith<_$HistoryDeckCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryDeckLoadingCopyWith<$Res>
    implements $HistoryDeckCopyWith<$Res> {
  factory _$$HistoryDeckLoadingCopyWith(_$HistoryDeckLoading value,
          $Res Function(_$HistoryDeckLoading) then) =
      __$$HistoryDeckLoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class __$$HistoryDeckLoadingCopyWithImpl<$Res>
    extends _$HistoryDeckCopyWithImpl<$Res, _$HistoryDeckLoading>
    implements _$$HistoryDeckLoadingCopyWith<$Res> {
  __$$HistoryDeckLoadingCopyWithImpl(
      _$HistoryDeckLoading _value, $Res Function(_$HistoryDeckLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$HistoryDeckLoading(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HistoryDeckLoading implements HistoryDeckLoading {
  const _$HistoryDeckLoading(
      {required this.createdAt,
      required this.name,
      required this.numberOfCards});

  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'HistoryDeck.loading(createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryDeckLoading &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards));
  }

  @override
  int get hashCode => Object.hash(runtimeType, createdAt, name, numberOfCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryDeckLoadingCopyWith<_$HistoryDeckLoading> get copyWith =>
      __$$HistoryDeckLoadingCopyWithImpl<_$HistoryDeckLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, SessionDto sessionDto, int numberOfCards)
        created,
    required TResult Function(
            DateTime createdAt, String name, int numberOfCards)
        loading,
    required TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)
        error,
  }) {
    return loading(createdAt, name, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult? Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
  }) {
    return loading?.call(createdAt, name, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(createdAt, name, numberOfCards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryDeckCreated value) created,
    required TResult Function(HistoryDeckLoading value) loading,
    required TResult Function(HistoryDeckError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryDeckCreated value)? created,
    TResult? Function(HistoryDeckLoading value)? loading,
    TResult? Function(HistoryDeckError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryDeckCreated value)? created,
    TResult Function(HistoryDeckLoading value)? loading,
    TResult Function(HistoryDeckError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class HistoryDeckLoading implements HistoryDeck {
  const factory HistoryDeckLoading(
      {required final DateTime createdAt,
      required final String name,
      required final int numberOfCards}) = _$HistoryDeckLoading;

  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$HistoryDeckLoadingCopyWith<_$HistoryDeckLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HistoryDeckErrorCopyWith<$Res>
    implements $HistoryDeckCopyWith<$Res> {
  factory _$$HistoryDeckErrorCopyWith(
          _$HistoryDeckError value, $Res Function(_$HistoryDeckError) then) =
      __$$HistoryDeckErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class __$$HistoryDeckErrorCopyWithImpl<$Res>
    extends _$HistoryDeckCopyWithImpl<$Res, _$HistoryDeckError>
    implements _$$HistoryDeckErrorCopyWith<$Res> {
  __$$HistoryDeckErrorCopyWithImpl(
      _$HistoryDeckError _value, $Res Function(_$HistoryDeckError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$HistoryDeckError(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$HistoryDeckError implements HistoryDeckError {
  const _$HistoryDeckError(
      {required this.message,
      required this.createdAt,
      required this.name,
      required this.numberOfCards});

  @override
  final String message;
  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'HistoryDeck.error(message: $message, createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryDeckError &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, createdAt, name, numberOfCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryDeckErrorCopyWith<_$HistoryDeckError> get copyWith =>
      __$$HistoryDeckErrorCopyWithImpl<_$HistoryDeckError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, SessionDto sessionDto, int numberOfCards)
        created,
    required TResult Function(
            DateTime createdAt, String name, int numberOfCards)
        loading,
    required TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)
        error,
  }) {
    return error(message, createdAt, name, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult? Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
  }) {
    return error?.call(message, createdAt, name, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            SessionDto sessionDto, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, createdAt, name, numberOfCards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HistoryDeckCreated value) created,
    required TResult Function(HistoryDeckLoading value) loading,
    required TResult Function(HistoryDeckError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HistoryDeckCreated value)? created,
    TResult? Function(HistoryDeckLoading value)? loading,
    TResult? Function(HistoryDeckError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HistoryDeckCreated value)? created,
    TResult Function(HistoryDeckLoading value)? loading,
    TResult Function(HistoryDeckError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class HistoryDeckError implements HistoryDeck {
  const factory HistoryDeckError(
      {required final String message,
      required final DateTime createdAt,
      required final String name,
      required final int numberOfCards}) = _$HistoryDeckError;

  String get message;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$HistoryDeckErrorCopyWith<_$HistoryDeckError> get copyWith =>
      throw _privateConstructorUsedError;
}
