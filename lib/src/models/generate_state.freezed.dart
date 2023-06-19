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
    required TResult Function(
            String? sessionId, Language? language, bool isUploadFile)
        loading,
    required TResult Function(
            String message, String sessionId, Language? language)
        error,
    required TResult Function(
            String sessionId, String? downloadUrl, Language? language)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult? Function(String message, String sessionId, Language? language)?
        error,
    TResult? Function(
            String sessionId, String? downloadUrl, Language? language)?
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult Function(String message, String sessionId, Language? language)?
        error,
    TResult Function(String sessionId, String? downloadUrl, Language? language)?
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
    required TResult Function(
            String? sessionId, Language? language, bool isUploadFile)
        loading,
    required TResult Function(
            String message, String sessionId, Language? language)
        error,
    required TResult Function(
            String sessionId, String? downloadUrl, Language? language)
        success,
  }) {
    return initial(slide);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult? Function(String message, String sessionId, Language? language)?
        error,
    TResult? Function(
            String sessionId, String? downloadUrl, Language? language)?
        success,
  }) {
    return initial?.call(slide);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult Function(String message, String sessionId, Language? language)?
        error,
    TResult Function(String sessionId, String? downloadUrl, Language? language)?
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
  $Res call({String? sessionId, Language? language, bool isUploadFile});
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
    Object? sessionId = freezed,
    Object? language = freezed,
    Object? isUploadFile = null,
  }) {
    return _then(_$GenerationStateLoading(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
      isUploadFile: null == isUploadFile
          ? _value.isUploadFile
          : isUploadFile // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GenerationStateLoading implements GenerationStateLoading {
  const _$GenerationStateLoading(
      {this.sessionId, this.language, this.isUploadFile = false});

  @override
  final String? sessionId;
  @override
  final Language? language;
  @override
  @JsonKey()
  final bool isUploadFile;

  @override
  String toString() {
    return 'GenerateState.loading(sessionId: $sessionId, language: $language, isUploadFile: $isUploadFile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateLoading &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.isUploadFile, isUploadFile) ||
                other.isUploadFile == isUploadFile));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, language, isUploadFile);

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
    required TResult Function(
            String? sessionId, Language? language, bool isUploadFile)
        loading,
    required TResult Function(
            String message, String sessionId, Language? language)
        error,
    required TResult Function(
            String sessionId, String? downloadUrl, Language? language)
        success,
  }) {
    return loading(sessionId, language, isUploadFile);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult? Function(String message, String sessionId, Language? language)?
        error,
    TResult? Function(
            String sessionId, String? downloadUrl, Language? language)?
        success,
  }) {
    return loading?.call(sessionId, language, isUploadFile);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult Function(String message, String sessionId, Language? language)?
        error,
    TResult Function(String sessionId, String? downloadUrl, Language? language)?
        success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(sessionId, language, isUploadFile);
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
      {final String? sessionId,
      final Language? language,
      final bool isUploadFile}) = _$GenerationStateLoading;

  String? get sessionId;
  Language? get language;
  bool get isUploadFile;
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
  $Res call({String message, String sessionId, Language? language});
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
    Object? sessionId = null,
    Object? language = freezed,
  }) {
    return _then(_$GenerationStateError(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
    ));
  }
}

/// @nodoc

class _$GenerationStateError implements GenerationStateError {
  const _$GenerationStateError(
      {required this.message, required this.sessionId, this.language});

  @override
  final String message;
  @override
  final String sessionId;
  @override
  final Language? language;

  @override
  String toString() {
    return 'GenerateState.error(message: $message, sessionId: $sessionId, language: $language)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateError &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, sessionId, language);

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
    required TResult Function(
            String? sessionId, Language? language, bool isUploadFile)
        loading,
    required TResult Function(
            String message, String sessionId, Language? language)
        error,
    required TResult Function(
            String sessionId, String? downloadUrl, Language? language)
        success,
  }) {
    return error(message, sessionId, language);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult? Function(String message, String sessionId, Language? language)?
        error,
    TResult? Function(
            String sessionId, String? downloadUrl, Language? language)?
        success,
  }) {
    return error?.call(message, sessionId, language);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult Function(String message, String sessionId, Language? language)?
        error,
    TResult Function(String sessionId, String? downloadUrl, Language? language)?
        success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, sessionId, language);
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
  const factory GenerationStateError(
      {required final String message,
      required final String sessionId,
      final Language? language}) = _$GenerationStateError;

  String get message;
  String get sessionId;
  Language? get language;
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
  $Res call({String sessionId, String? downloadUrl, Language? language});
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
    Object? sessionId = null,
    Object? downloadUrl = freezed,
    Object? language = freezed,
  }) {
    return _then(_$GenerationStateSuccess(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
    ));
  }
}

/// @nodoc

class _$GenerationStateSuccess implements GenerationStateSuccess {
  const _$GenerationStateSuccess(
      {required this.sessionId, required this.downloadUrl, this.language});

  @override
  final String sessionId;
  @override
  final String? downloadUrl;
  @override
  final Language? language;

  @override
  String toString() {
    return 'GenerateState.success(sessionId: $sessionId, downloadUrl: $downloadUrl, language: $language)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationStateSuccess &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, downloadUrl, language);

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
    required TResult Function(
            String? sessionId, Language? language, bool isUploadFile)
        loading,
    required TResult Function(
            String message, String sessionId, Language? language)
        error,
    required TResult Function(
            String sessionId, String? downloadUrl, Language? language)
        success,
  }) {
    return success(sessionId, downloadUrl, language);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String slide)? initial,
    TResult? Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult? Function(String message, String sessionId, Language? language)?
        error,
    TResult? Function(
            String sessionId, String? downloadUrl, Language? language)?
        success,
  }) {
    return success?.call(sessionId, downloadUrl, language);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String slide)? initial,
    TResult Function(String? sessionId, Language? language, bool isUploadFile)?
        loading,
    TResult Function(String message, String sessionId, Language? language)?
        error,
    TResult Function(String sessionId, String? downloadUrl, Language? language)?
        success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(sessionId, downloadUrl, language);
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
      {required final String sessionId,
      required final String? downloadUrl,
      final Language? language}) = _$GenerationStateSuccess;

  String get sessionId;
  String? get downloadUrl;
  Language? get language;
  @JsonKey(ignore: true)
  _$$GenerationStateSuccessCopyWith<_$GenerationStateSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CardsListView {
  List<AnkiCard> get cards => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get canPressNext => throw _privateConstructorUsedError;
  bool get canPressPrevious => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardsListViewCopyWith<CardsListView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardsListViewCopyWith<$Res> {
  factory $CardsListViewCopyWith(
          CardsListView value, $Res Function(CardsListView) then) =
      _$CardsListViewCopyWithImpl<$Res, CardsListView>;
  @useResult
  $Res call(
      {List<AnkiCard> cards,
      int currentPage,
      int totalPages,
      bool canPressNext,
      bool canPressPrevious});
}

/// @nodoc
class _$CardsListViewCopyWithImpl<$Res, $Val extends CardsListView>
    implements $CardsListViewCopyWith<$Res> {
  _$CardsListViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? canPressNext = null,
    Object? canPressPrevious = null,
  }) {
    return _then(_value.copyWith(
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      canPressNext: null == canPressNext
          ? _value.canPressNext
          : canPressNext // ignore: cast_nullable_to_non_nullable
              as bool,
      canPressPrevious: null == canPressPrevious
          ? _value.canPressPrevious
          : canPressPrevious // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CardsListViewCopyWith<$Res>
    implements $CardsListViewCopyWith<$Res> {
  factory _$$_CardsListViewCopyWith(
          _$_CardsListView value, $Res Function(_$_CardsListView) then) =
      __$$_CardsListViewCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AnkiCard> cards,
      int currentPage,
      int totalPages,
      bool canPressNext,
      bool canPressPrevious});
}

/// @nodoc
class __$$_CardsListViewCopyWithImpl<$Res>
    extends _$CardsListViewCopyWithImpl<$Res, _$_CardsListView>
    implements _$$_CardsListViewCopyWith<$Res> {
  __$$_CardsListViewCopyWithImpl(
      _$_CardsListView _value, $Res Function(_$_CardsListView) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? canPressNext = null,
    Object? canPressPrevious = null,
  }) {
    return _then(_$_CardsListView(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<AnkiCard>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      canPressNext: null == canPressNext
          ? _value.canPressNext
          : canPressNext // ignore: cast_nullable_to_non_nullable
              as bool,
      canPressPrevious: null == canPressPrevious
          ? _value.canPressPrevious
          : canPressPrevious // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CardsListView extends _CardsListView {
  const _$_CardsListView(
      {required final List<AnkiCard> cards,
      required this.currentPage,
      required this.totalPages,
      required this.canPressNext,
      required this.canPressPrevious})
      : _cards = cards,
        super._();

  final List<AnkiCard> _cards;
  @override
  List<AnkiCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  final bool canPressNext;
  @override
  final bool canPressPrevious;

  @override
  String toString() {
    return 'CardsListView(cards: $cards, currentPage: $currentPage, totalPages: $totalPages, canPressNext: $canPressNext, canPressPrevious: $canPressPrevious)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CardsListView &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.canPressNext, canPressNext) ||
                other.canPressNext == canPressNext) &&
            (identical(other.canPressPrevious, canPressPrevious) ||
                other.canPressPrevious == canPressPrevious));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cards),
      currentPage,
      totalPages,
      canPressNext,
      canPressPrevious);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CardsListViewCopyWith<_$_CardsListView> get copyWith =>
      __$$_CardsListViewCopyWithImpl<_$_CardsListView>(this, _$identity);
}

abstract class _CardsListView extends CardsListView {
  const factory _CardsListView(
      {required final List<AnkiCard> cards,
      required final int currentPage,
      required final int totalPages,
      required final bool canPressNext,
      required final bool canPressPrevious}) = _$_CardsListView;
  const _CardsListView._() : super._();

  @override
  List<AnkiCard> get cards;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  bool get canPressNext;
  @override
  bool get canPressPrevious;
  @override
  @JsonKey(ignore: true)
  _$$_CardsListViewCopyWith<_$_CardsListView> get copyWith =>
      throw _privateConstructorUsedError;
}
