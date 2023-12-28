// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WatchView {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get downloadUrl => throw _privateConstructorUsedError;
  Language? get language => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get sessionId => throw _privateConstructorUsedError;
  String? get inputText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WatchViewCopyWith<WatchView> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchViewCopyWith<$Res> {
  factory $WatchViewCopyWith(WatchView value, $Res Function(WatchView) then) =
      _$WatchViewCopyWithImpl<$Res, WatchView>;
  @useResult
  $Res call(
      {bool isLoading,
      String? downloadUrl,
      Language? language,
      String? error,
      String? fileName,
      String? sessionId,
      String? inputText});
}

/// @nodoc
class _$WatchViewCopyWithImpl<$Res, $Val extends WatchView>
    implements $WatchViewCopyWith<$Res> {
  _$WatchViewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? downloadUrl = freezed,
    Object? language = freezed,
    Object? error = freezed,
    Object? fileName = freezed,
    Object? sessionId = freezed,
    Object? inputText = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      inputText: freezed == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchViewImplCopyWith<$Res>
    implements $WatchViewCopyWith<$Res> {
  factory _$$WatchViewImplCopyWith(
          _$WatchViewImpl value, $Res Function(_$WatchViewImpl) then) =
      __$$WatchViewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? downloadUrl,
      Language? language,
      String? error,
      String? fileName,
      String? sessionId,
      String? inputText});
}

/// @nodoc
class __$$WatchViewImplCopyWithImpl<$Res>
    extends _$WatchViewCopyWithImpl<$Res, _$WatchViewImpl>
    implements _$$WatchViewImplCopyWith<$Res> {
  __$$WatchViewImplCopyWithImpl(
      _$WatchViewImpl _value, $Res Function(_$WatchViewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? downloadUrl = freezed,
    Object? language = freezed,
    Object? error = freezed,
    Object? fileName = freezed,
    Object? sessionId = freezed,
    Object? inputText = freezed,
  }) {
    return _then(_$WatchViewImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      inputText: freezed == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WatchViewImpl extends _WatchView {
  const _$WatchViewImpl(
      {this.isLoading = false,
      this.downloadUrl,
      this.language,
      this.error,
      this.fileName,
      this.sessionId,
      this.inputText})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? downloadUrl;
  @override
  final Language? language;
  @override
  final String? error;
  @override
  final String? fileName;
  @override
  final String? sessionId;
  @override
  final String? inputText;

  @override
  String toString() {
    return 'WatchView(isLoading: $isLoading, downloadUrl: $downloadUrl, language: $language, error: $error, fileName: $fileName, sessionId: $sessionId, inputText: $inputText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchViewImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.inputText, inputText) ||
                other.inputText == inputText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, downloadUrl, language,
      error, fileName, sessionId, inputText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchViewImplCopyWith<_$WatchViewImpl> get copyWith =>
      __$$WatchViewImplCopyWithImpl<_$WatchViewImpl>(this, _$identity);
}

abstract class _WatchView extends WatchView {
  const factory _WatchView(
      {final bool isLoading,
      final String? downloadUrl,
      final Language? language,
      final String? error,
      final String? fileName,
      final String? sessionId,
      final String? inputText}) = _$WatchViewImpl;
  const _WatchView._() : super._();

  @override
  bool get isLoading;
  @override
  String? get downloadUrl;
  @override
  Language? get language;
  @override
  String? get error;
  @override
  String? get fileName;
  @override
  String? get sessionId;
  @override
  String? get inputText;
  @override
  @JsonKey(ignore: true)
  _$$WatchViewImplCopyWith<_$WatchViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
