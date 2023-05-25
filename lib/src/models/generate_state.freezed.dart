// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GenerateState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String slide) initial,
    required TResult Function(List<AnkiCard> alreadyGeneratedCards) loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<AnkiCard> generatedCards, String? downloadUrl)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult Function(String message)? error,
    TResult Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerationStateInitial value) initial,
    required TResult Function(GenerationStateLoading value) loading,
    required TResult Function(GenerationStateError value) error,
    required TResult Function(GenerationStateSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerationStateInitial value)? initial,
    TResult? Function(GenerationStateLoading value)? loading,
    TResult? Function(GenerationStateError value)? error,
    TResult? Function(GenerationStateSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerationStateInitial value)? initial,
    TResult Function(GenerationStateLoading value)? loading,
    TResult Function(GenerationStateError value)? error,
    TResult Function(GenerationStateSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerateStateCopyWith<$Res> {
  factory $GenerateStateCopyWith(
          GenerateState value, $Res Function(GenerateState) then) =
      _$GenerateStateCopyWithImpl<$Res, GenerateState>;
}

/// @nodoc
class _$GenerateStateCopyWithImpl<$Res, $Val extends GenerateState>
    implements $GenerateStateCopyWith<$Res> {
  _$GenerateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GenerationStateInitialCopyWith<$Res> {
  factory _$$GenerationStateInitialCopyWith(_$GenerationStateInitial value,
          $Res Function(_$GenerationStateInitial) then) =
      __$$GenerationStateInitialCopyWithImpl<$Res>;
  @useResult
  $Res call({String slide});
}

/// @nodoc
class __$$GenerationStateInitialCopyWithImpl<$Res>
    extends _$GenerateStateCopyWithImpl<$Res, _$GenerationStateInitial>
    implements _$$GenerationStateInitialCopyWith<$Res> {
  __$$GenerationStateInitialCopyWithImpl(_$GenerationStateInitial _value,
      $Res Function(_$GenerationStateInitial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slide = null,
  }) {
    return _then(_$GenerationStateInitial(
      slide: null == slide
          ? _value.slide
          : slide // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GenerationStateInitial implements GenerationStateInitial {
  const _$GenerationStateInitial({this.slide = ''});

  @override
  @JsonKey()
  final String slide;

  @override
  String toString() {
    return 'GenerateState.initial(slide: $slide)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateInitial &&
            (identical(other.slide, slide) || other.slide == slide));
  }

  @override
  int get hashCode => Object.hash(runtimeType, slide);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationStateInitialCopyWith<_$GenerationStateInitial> get copyWith =>
      __$$GenerationStateInitialCopyWithImpl<_$GenerationStateInitial>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String slide) initial,
    required TResult Function(List<AnkiCard> alreadyGeneratedCards) loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<AnkiCard> generatedCards, String? downloadUrl)
        success,
  }) {
    return initial(slide);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
  }) {
    return initial?.call(slide);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult Function(String message)? error,
    TResult Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(slide);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerationStateInitial value) initial,
    required TResult Function(GenerationStateLoading value) loading,
    required TResult Function(GenerationStateError value) error,
    required TResult Function(GenerationStateSuccess value) success,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerationStateInitial value)? initial,
    TResult? Function(GenerationStateLoading value)? loading,
    TResult? Function(GenerationStateError value)? error,
    TResult? Function(GenerationStateSuccess value)? success,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerationStateInitial value)? initial,
    TResult Function(GenerationStateLoading value)? loading,
    TResult Function(GenerationStateError value)? error,
    TResult Function(GenerationStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class GenerationStateInitial implements GenerateState {
  const factory GenerationStateInitial({final String slide}) =
      _$GenerationStateInitial;

  String get slide;
  @JsonKey(ignore: true)
  _$$GenerationStateInitialCopyWith<_$GenerationStateInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenerationStateLoadingCopyWith<$Res> {
  factory _$$GenerationStateLoadingCopyWith(_$GenerationStateLoading value,
          $Res Function(_$GenerationStateLoading) then) =
      __$$GenerationStateLoadingCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AnkiCard> alreadyGeneratedCards});
}

/// @nodoc
class __$$GenerationStateLoadingCopyWithImpl<$Res>
    extends _$GenerateStateCopyWithImpl<$Res, _$GenerationStateLoading>
    implements _$$GenerationStateLoadingCopyWith<$Res> {
  __$$GenerationStateLoadingCopyWithImpl(_$GenerationStateLoading _value,
      $Res Function(_$GenerationStateLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alreadyGeneratedCards = null,
  }) {
    return _then(_$GenerationStateLoading(
      alreadyGeneratedCards: null == alreadyGeneratedCards
          ? _value._alreadyGeneratedCards
          : alreadyGeneratedCards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
    ));
  }
}

/// @nodoc

class _$GenerationStateLoading implements GenerationStateLoading {
  const _$GenerationStateLoading(
      {final List<AnkiCard> alreadyGeneratedCards = const []})
      : _alreadyGeneratedCards = alreadyGeneratedCards;

  final List<AnkiCard> _alreadyGeneratedCards;
  @override
  @JsonKey()
  List<AnkiCard> get alreadyGeneratedCards {
    if (_alreadyGeneratedCards is EqualUnmodifiableListView)
      return _alreadyGeneratedCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alreadyGeneratedCards);
  }

  @override
  String toString() {
    return 'GenerateState.loading(alreadyGeneratedCards: $alreadyGeneratedCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateLoading &&
            const DeepCollectionEquality()
                .equals(other._alreadyGeneratedCards, _alreadyGeneratedCards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_alreadyGeneratedCards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationStateLoadingCopyWith<_$GenerationStateLoading> get copyWith =>
      __$$GenerationStateLoadingCopyWithImpl<_$GenerationStateLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String slide) initial,
    required TResult Function(List<AnkiCard> alreadyGeneratedCards) loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<AnkiCard> generatedCards, String? downloadUrl)
        success,
  }) {
    return loading(alreadyGeneratedCards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
  }) {
    return loading?.call(alreadyGeneratedCards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult Function(String message)? error,
    TResult Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(alreadyGeneratedCards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerationStateInitial value) initial,
    required TResult Function(GenerationStateLoading value) loading,
    required TResult Function(GenerationStateError value) error,
    required TResult Function(GenerationStateSuccess value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerationStateInitial value)? initial,
    TResult? Function(GenerationStateLoading value)? loading,
    TResult? Function(GenerationStateError value)? error,
    TResult? Function(GenerationStateSuccess value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerationStateInitial value)? initial,
    TResult Function(GenerationStateLoading value)? loading,
    TResult Function(GenerationStateError value)? error,
    TResult Function(GenerationStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GenerationStateLoading implements GenerateState {
  const factory GenerationStateLoading(
      {final List<AnkiCard> alreadyGeneratedCards}) = _$GenerationStateLoading;

  List<AnkiCard> get alreadyGeneratedCards;
  @JsonKey(ignore: true)
  _$$GenerationStateLoadingCopyWith<_$GenerationStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenerationStateErrorCopyWith<$Res> {
  factory _$$GenerationStateErrorCopyWith(_$GenerationStateError value,
          $Res Function(_$GenerationStateError) then) =
      __$$GenerationStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GenerationStateErrorCopyWithImpl<$Res>
    extends _$GenerateStateCopyWithImpl<$Res, _$GenerationStateError>
    implements _$$GenerationStateErrorCopyWith<$Res> {
  __$$GenerationStateErrorCopyWithImpl(_$GenerationStateError _value,
      $Res Function(_$GenerationStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GenerationStateError(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GenerationStateError implements GenerationStateError {
  const _$GenerationStateError({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'GenerateState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationStateErrorCopyWith<_$GenerationStateError> get copyWith =>
      __$$GenerationStateErrorCopyWithImpl<_$GenerationStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String slide) initial,
    required TResult Function(List<AnkiCard> alreadyGeneratedCards) loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<AnkiCard> generatedCards, String? downloadUrl)
        success,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult Function(String message)? error,
    TResult Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerationStateInitial value) initial,
    required TResult Function(GenerationStateLoading value) loading,
    required TResult Function(GenerationStateError value) error,
    required TResult Function(GenerationStateSuccess value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerationStateInitial value)? initial,
    TResult? Function(GenerationStateLoading value)? loading,
    TResult? Function(GenerationStateError value)? error,
    TResult? Function(GenerationStateSuccess value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerationStateInitial value)? initial,
    TResult Function(GenerationStateLoading value)? loading,
    TResult Function(GenerationStateError value)? error,
    TResult Function(GenerationStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GenerationStateError implements GenerateState {
  const factory GenerationStateError({required final String message}) =
      _$GenerationStateError;

  String get message;
  @JsonKey(ignore: true)
  _$$GenerationStateErrorCopyWith<_$GenerationStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenerationStateSuccessCopyWith<$Res> {
  factory _$$GenerationStateSuccessCopyWith(_$GenerationStateSuccess value,
          $Res Function(_$GenerationStateSuccess) then) =
      __$$GenerationStateSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AnkiCard> generatedCards, String? downloadUrl});
}

/// @nodoc
class __$$GenerationStateSuccessCopyWithImpl<$Res>
    extends _$GenerateStateCopyWithImpl<$Res, _$GenerationStateSuccess>
    implements _$$GenerationStateSuccessCopyWith<$Res> {
  __$$GenerationStateSuccessCopyWithImpl(_$GenerationStateSuccess _value,
      $Res Function(_$GenerationStateSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generatedCards = null,
    Object? downloadUrl = freezed,
  }) {
    return _then(_$GenerationStateSuccess(
      generatedCards: null == generatedCards
          ? _value._generatedCards
          : generatedCards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GenerationStateSuccess implements GenerationStateSuccess {
  const _$GenerationStateSuccess(
      {required final List<AnkiCard> generatedCards, required this.downloadUrl})
      : _generatedCards = generatedCards;

  final List<AnkiCard> _generatedCards;
  @override
  List<AnkiCard> get generatedCards {
    if (_generatedCards is EqualUnmodifiableListView) return _generatedCards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_generatedCards);
  }

  @override
  final String? downloadUrl;

  @override
  String toString() {
    return 'GenerateState.success(generatedCards: $generatedCards, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateSuccess &&
            const DeepCollectionEquality()
                .equals(other._generatedCards, _generatedCards) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_generatedCards), downloadUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationStateSuccessCopyWith<_$GenerationStateSuccess> get copyWith =>
      __$$GenerationStateSuccessCopyWithImpl<_$GenerationStateSuccess>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String slide) initial,
    required TResult Function(List<AnkiCard> alreadyGeneratedCards) loading,
    required TResult Function(String message) error,
    required TResult Function(
            List<AnkiCard> generatedCards, String? downloadUrl)
        success,
  }) {
    return success(generatedCards, downloadUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult? Function(String message)? error,
    TResult? Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
  }) {
    return success?.call(generatedCards, downloadUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(List<AnkiCard> alreadyGeneratedCards)? loading,
    TResult Function(String message)? error,
    TResult Function(List<AnkiCard> generatedCards, String? downloadUrl)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(generatedCards, downloadUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerationStateInitial value) initial,
    required TResult Function(GenerationStateLoading value) loading,
    required TResult Function(GenerationStateError value) error,
    required TResult Function(GenerationStateSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerationStateInitial value)? initial,
    TResult? Function(GenerationStateLoading value)? loading,
    TResult? Function(GenerationStateError value)? error,
    TResult? Function(GenerationStateSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerationStateInitial value)? initial,
    TResult Function(GenerationStateLoading value)? loading,
    TResult Function(GenerationStateError value)? error,
    TResult Function(GenerationStateSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class GenerationStateSuccess implements GenerateState {
  const factory GenerationStateSuccess(
      {required final List<AnkiCard> generatedCards,
      required final String? downloadUrl}) = _$GenerationStateSuccess;

  List<AnkiCard> get generatedCards;
  String? get downloadUrl;
  @JsonKey(ignore: true)
  _$$GenerationStateSuccessCopyWith<_$GenerationStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}
