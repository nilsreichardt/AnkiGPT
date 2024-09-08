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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeckPreview {
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;
  Model get model => throw _privateConstructorUsedError;
  int get numberOfCards => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, Model model, int numberOfCards)
        created,
    required TResult Function(DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        loading,
    required TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult? Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
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

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeckPreviewCopyWith<DeckPreview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckPreviewCopyWith<$Res> {
  factory $DeckPreviewCopyWith(
          DeckPreview value, $Res Function(DeckPreview) then) =
      _$DeckPreviewCopyWithImpl<$Res, DeckPreview>;
  @useResult
  $Res call(
      {DateTime createdAt,
      String name,
      String sessionId,
      Model model,
      int numberOfCards});
}

/// @nodoc
class _$DeckPreviewCopyWithImpl<$Res, $Val extends DeckPreview>
    implements $DeckPreviewCopyWith<$Res> {
  _$DeckPreviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? name = null,
    Object? sessionId = null,
    Object? model = null,
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
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeckPreviewCreatedImplCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewCreatedImplCopyWith(_$DeckPreviewCreatedImpl value,
          $Res Function(_$DeckPreviewCreatedImpl) then) =
      __$$DeckPreviewCreatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> questions,
      DateTime createdAt,
      String name,
      String sessionId,
      Model model,
      int numberOfCards});
}

/// @nodoc
class __$$DeckPreviewCreatedImplCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewCreatedImpl>
    implements _$$DeckPreviewCreatedImplCopyWith<$Res> {
  __$$DeckPreviewCreatedImplCopyWithImpl(_$DeckPreviewCreatedImpl _value,
      $Res Function(_$DeckPreviewCreatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questions = null,
    Object? createdAt = null,
    Object? name = null,
    Object? sessionId = null,
    Object? model = null,
    Object? numberOfCards = null,
  }) {
    return _then(_$DeckPreviewCreatedImpl(
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
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeckPreviewCreatedImpl implements DeckPreviewCreated {
  const _$DeckPreviewCreatedImpl(
      {required final List<String> questions,
      required this.createdAt,
      required this.name,
      required this.sessionId,
      required this.model,
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
  final Model model;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'DeckPreview.created(questions: $questions, createdAt: $createdAt, name: $name, sessionId: $sessionId, model: $model, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewCreatedImpl &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.model, model) || other.model == model) &&
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
      model,
      numberOfCards);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckPreviewCreatedImplCopyWith<_$DeckPreviewCreatedImpl> get copyWith =>
      __$$DeckPreviewCreatedImplCopyWithImpl<_$DeckPreviewCreatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, Model model, int numberOfCards)
        created,
    required TResult Function(DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        loading,
    required TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        error,
  }) {
    return created(questions, createdAt, name, sessionId, model, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult? Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
  }) {
    return created?.call(
        questions, createdAt, name, sessionId, model, numberOfCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(
          questions, createdAt, name, sessionId, model, numberOfCards);
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
      required final Model model,
      required final int numberOfCards}) = _$DeckPreviewCreatedImpl;

  List<String> get questions;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  String get sessionId;
  @override
  Model get model;
  @override
  int get numberOfCards;

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckPreviewCreatedImplCopyWith<_$DeckPreviewCreatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckPreviewLoadingImplCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewLoadingImplCopyWith(_$DeckPreviewLoadingImpl value,
          $Res Function(_$DeckPreviewLoadingImpl) then) =
      __$$DeckPreviewLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime createdAt,
      String name,
      int numberOfCards,
      String sessionId,
      Model model});
}

/// @nodoc
class __$$DeckPreviewLoadingImplCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewLoadingImpl>
    implements _$$DeckPreviewLoadingImplCopyWith<$Res> {
  __$$DeckPreviewLoadingImplCopyWithImpl(_$DeckPreviewLoadingImpl _value,
      $Res Function(_$DeckPreviewLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
    Object? sessionId = null,
    Object? model = null,
  }) {
    return _then(_$DeckPreviewLoadingImpl(
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
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$DeckPreviewLoadingImpl implements DeckPreviewLoading {
  const _$DeckPreviewLoadingImpl(
      {required this.createdAt,
      required this.name,
      required this.numberOfCards,
      required this.sessionId,
      required this.model});

  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final int numberOfCards;
  @override
  final String sessionId;
  @override
  final Model model;

  @override
  String toString() {
    return 'DeckPreview.loading(createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards, sessionId: $sessionId, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewLoadingImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, createdAt, name, numberOfCards, sessionId, model);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckPreviewLoadingImplCopyWith<_$DeckPreviewLoadingImpl> get copyWith =>
      __$$DeckPreviewLoadingImplCopyWithImpl<_$DeckPreviewLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, Model model, int numberOfCards)
        created,
    required TResult Function(DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        loading,
    required TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        error,
  }) {
    return loading(createdAt, name, numberOfCards, sessionId, model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult? Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
  }) {
    return loading?.call(createdAt, name, numberOfCards, sessionId, model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(createdAt, name, numberOfCards, sessionId, model);
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
      required final int numberOfCards,
      required final String sessionId,
      required final Model model}) = _$DeckPreviewLoadingImpl;

  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  String get sessionId;
  @override
  Model get model;

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckPreviewLoadingImplCopyWith<_$DeckPreviewLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeckPreviewErrorImplCopyWith<$Res>
    implements $DeckPreviewCopyWith<$Res> {
  factory _$$DeckPreviewErrorImplCopyWith(_$DeckPreviewErrorImpl value,
          $Res Function(_$DeckPreviewErrorImpl) then) =
      __$$DeckPreviewErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      DateTime createdAt,
      String name,
      int numberOfCards,
      String sessionId,
      Model model});
}

/// @nodoc
class __$$DeckPreviewErrorImplCopyWithImpl<$Res>
    extends _$DeckPreviewCopyWithImpl<$Res, _$DeckPreviewErrorImpl>
    implements _$$DeckPreviewErrorImplCopyWith<$Res> {
  __$$DeckPreviewErrorImplCopyWithImpl(_$DeckPreviewErrorImpl _value,
      $Res Function(_$DeckPreviewErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? createdAt = null,
    Object? name = null,
    Object? numberOfCards = null,
    Object? sessionId = null,
    Object? model = null,
  }) {
    return _then(_$DeckPreviewErrorImpl(
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
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
    ));
  }
}

/// @nodoc

class _$DeckPreviewErrorImpl implements DeckPreviewError {
  const _$DeckPreviewErrorImpl(
      {required this.message,
      required this.createdAt,
      required this.name,
      required this.numberOfCards,
      required this.sessionId,
      required this.model});

  @override
  final String message;
  @override
  final DateTime createdAt;
  @override
  final String name;
  @override
  final int numberOfCards;
  @override
  final String sessionId;
  @override
  final Model model;

  @override
  String toString() {
    return 'DeckPreview.error(message: $message, createdAt: $createdAt, name: $name, numberOfCards: $numberOfCards, sessionId: $sessionId, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckPreviewErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.model, model) || other.model == model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, createdAt, name, numberOfCards, sessionId, model);

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckPreviewErrorImplCopyWith<_$DeckPreviewErrorImpl> get copyWith =>
      __$$DeckPreviewErrorImplCopyWithImpl<_$DeckPreviewErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<String> questions, DateTime createdAt,
            String name, String sessionId, Model model, int numberOfCards)
        created,
    required TResult Function(DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        loading,
    required TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)
        error,
  }) {
    return error(message, createdAt, name, numberOfCards, sessionId, model);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult? Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult? Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
  }) {
    return error?.call(
        message, createdAt, name, numberOfCards, sessionId, model);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<String> questions, DateTime createdAt, String name,
            String sessionId, Model model, int numberOfCards)?
        created,
    TResult Function(DateTime createdAt, String name, int numberOfCards,
            String sessionId, Model model)?
        loading,
    TResult Function(String message, DateTime createdAt, String name,
            int numberOfCards, String sessionId, Model model)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, createdAt, name, numberOfCards, sessionId, model);
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
      required final int numberOfCards,
      required final String sessionId,
      required final Model model}) = _$DeckPreviewErrorImpl;

  String get message;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get numberOfCards;
  @override
  String get sessionId;
  @override
  Model get model;

  /// Create a copy of DeckPreview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckPreviewErrorImplCopyWith<_$DeckPreviewErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
