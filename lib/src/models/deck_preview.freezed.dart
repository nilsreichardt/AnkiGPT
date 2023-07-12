// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck_preview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeckPreview {
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get numberOfCards => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, int numberOfCards)
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
            String sessionId, int numberOfCards)?
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
            String sessionId, int numberOfCards)?
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
    required TResult Function(DeckPreviewCreated value) created,
    required TResult Function(DeckPreviewLoading value) loading,
    required TResult Function(DeckPreviewError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeckPreviewCreated value)? created,
    TResult? Function(DeckPreviewLoading value)? loading,
    TResult? Function(DeckPreviewError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeckPreviewCreated value)? created,
    TResult Function(DeckPreviewLoading value)? loading,
    TResult Function(DeckPreviewError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeckPreviewCopyWith<DeckPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckPreviewCopyWith<$Res> {
  factory $DeckPreviewCopyWith(
          DeckPreview value, $Res Function(DeckPreview) then) =
      _$DeckPreviewCopyWithImpl<$Res, DeckPreview>;
  @useResult
  $Res call({DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class _$DeckPreviewCopyWithImpl<$Res, $Val extends DeckPreview>
    implements $DeckPreviewCopyWith<$Res> {
  _$DeckPreviewCopyWithImpl(this._value, this._then);

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
abstract class _$$DeckPreviewCreatedCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewCreatedCopyWith(_$DeckPreviewCreated value,
          $Res Function(_$DeckPreviewCreated) then) =
      __$$DeckPreviewCreatedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> questions,
      DateTime createdAt,
      String name,
      String sessionId,
      int numberOfCards});
}

/// @nodoc
class __$$DeckPreviewCreatedCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewCreated>
    implements _$$DeckPreviewCreatedCopyWith<$Res> {
  __$$DeckPreviewCreatedCopyWithImpl(
      _$DeckPreviewCreated _value, $Res Function(_$DeckPreviewCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? createdAt = null,
    Object? name = null,
    Object? sessionId = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$DeckPreviewCreated(
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
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeckPreviewCreated implements DeckPreviewCreated {
  const _$DeckPreviewCreated(
      {required final List<String> questions,
      required this.createdAt,
      required this.name,
      required this.sessionId,
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
  final String sessionId;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'DeckPreview.created(questions: $questions, createdAt: $createdAt, name: $name, sessionId: $sessionId, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewCreated &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_questions),
      createdAt,
      name,
      sessionId,
      numberOfCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckPreviewCreatedCopyWith<_$DeckPreviewCreated> get copyWith =>
      __$$DeckPreviewCreatedCopyWithImpl<_$DeckPreviewCreated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, int numberOfCards)
        created,
    required TResult Function(
            DateTime createdAt, String name, int numberOfCards)
        loading,
    required TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)
        error,
  }) {
    return created(questions, createdAt, name, sessionId, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult? Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
  }) {
    return created?.call(questions, createdAt, name, sessionId, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards)?
        loading,
    TResult Function(
            String message, DateTime createdAt, String name, int numberOfCards)?
        error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(questions, createdAt, name, sessionId, numberOfCards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeckPreviewCreated value) created,
    required TResult Function(DeckPreviewLoading value) loading,
    required TResult Function(DeckPreviewError value) error,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeckPreviewCreated value)? created,
    TResult? Function(DeckPreviewLoading value)? loading,
    TResult? Function(DeckPreviewError value)? error,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeckPreviewCreated value)? created,
    TResult Function(DeckPreviewLoading value)? loading,
    TResult Function(DeckPreviewError value)? error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }
}

abstract class DeckPreviewCreated implements DeckPreview {
  const factory DeckPreviewCreated(
      {required final List<String> questions,
      required final DateTime createdAt,
      required final String name,
      required final String sessionId,
      required final int numberOfCards}) = _$DeckPreviewCreated;

  List<String> get questions;
  @override
  DateTime get createdAt;
  @override
  String get name;
  String get sessionId;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$DeckPreviewCreatedCopyWith<_$DeckPreviewCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckPreviewLoadingCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewLoadingCopyWith(_$DeckPreviewLoading value,
          $Res Function(_$DeckPreviewLoading) then) =
      __$$DeckPreviewLoadingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class __$$DeckPreviewLoadingCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewLoading>
    implements _$$DeckPreviewLoadingCopyWith<$Res> {
  __$$DeckPreviewLoadingCopyWithImpl(
      _$DeckPreviewLoading _value, $Res Function(_$DeckPreviewLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$DeckPreviewLoading(
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

class _$DeckPreviewLoading implements DeckPreviewLoading {
  const _$DeckPreviewLoading(
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
    return 'DeckPreview.loading(createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewLoading &&
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
  _$$DeckPreviewLoadingCopyWith<_$DeckPreviewLoading> get copyWith =>
      __$$DeckPreviewLoadingCopyWithImpl<_$DeckPreviewLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, int numberOfCards)
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
            String sessionId, int numberOfCards)?
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
            String sessionId, int numberOfCards)?
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
    required TResult Function(DeckPreviewCreated value) created,
    required TResult Function(DeckPreviewLoading value) loading,
    required TResult Function(DeckPreviewError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeckPreviewCreated value)? created,
    TResult? Function(DeckPreviewLoading value)? loading,
    TResult? Function(DeckPreviewError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeckPreviewCreated value)? created,
    TResult Function(DeckPreviewLoading value)? loading,
    TResult Function(DeckPreviewError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DeckPreviewLoading implements DeckPreview {
  const factory DeckPreviewLoading(
      {required final DateTime createdAt,
      required final String name,
      required final int numberOfCards}) = _$DeckPreviewLoading;

  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$DeckPreviewLoadingCopyWith<_$DeckPreviewLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckPreviewErrorCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewErrorCopyWith(
          _$DeckPreviewError value, $Res Function(_$DeckPreviewError) then) =
      __$$DeckPreviewErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, DateTime createdAt, String name, int numberOfCards});
}

/// @nodoc
class __$$DeckPreviewErrorCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewError>
    implements _$$DeckPreviewErrorCopyWith<$Res> {
  __$$DeckPreviewErrorCopyWithImpl(
      _$DeckPreviewError _value, $Res Function(_$DeckPreviewError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$DeckPreviewError(
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

class _$DeckPreviewError implements DeckPreviewError {
  const _$DeckPreviewError(
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
    return 'DeckPreview.error(message: $message, createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewError &&
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
  _$$DeckPreviewErrorCopyWith<_$DeckPreviewError> get copyWith =>
      __$$DeckPreviewErrorCopyWithImpl<_$DeckPreviewError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, int numberOfCards)
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
            String sessionId, int numberOfCards)?
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
            String sessionId, int numberOfCards)?
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
    required TResult Function(DeckPreviewCreated value) created,
    required TResult Function(DeckPreviewLoading value) loading,
    required TResult Function(DeckPreviewError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeckPreviewCreated value)? created,
    TResult? Function(DeckPreviewLoading value)? loading,
    TResult? Function(DeckPreviewError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeckPreviewCreated value)? created,
    TResult Function(DeckPreviewLoading value)? loading,
    TResult Function(DeckPreviewError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DeckPreviewError implements DeckPreview {
  const factory DeckPreviewError(
      {required final String message,
      required final DateTime createdAt,
      required final String name,
      required final int numberOfCards}) = _$DeckPreviewError;

  String get message;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$DeckPreviewErrorCopyWith<_$DeckPreviewError> get copyWith =>
      throw _privateConstructorUsedError;
}
