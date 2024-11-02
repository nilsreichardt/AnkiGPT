// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'options_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GenerationOptions {
  CardGenrationSize get size => throw _privateConstructorUsedError;
  Model get model => throw _privateConstructorUsedError;
  Language get language => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GenerationOptionsCopyWith<GenerationOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenerationOptionsCopyWith<$Res> {
  factory $GenerationOptionsCopyWith(
          GenerationOptions value, $Res Function(GenerationOptions) then) =
      _$GenerationOptionsCopyWithImpl<$Res, GenerationOptions>;
  @useResult
  $Res call({CardGenrationSize size, Model model, Language language});
}

/// @nodoc
class _$GenerationOptionsCopyWithImpl<$Res, $Val extends GenerationOptions>
    implements $GenerationOptionsCopyWith<$Res> {
  _$GenerationOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? model = null,
    Object? language = null,
  }) {
    return _then(_value.copyWith(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as CardGenrationSize,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GenerationOptionsImplCopyWith<$Res>
    implements $GenerationOptionsCopyWith<$Res> {
  factory _$$GenerationOptionsImplCopyWith(_$GenerationOptionsImpl value,
          $Res Function(_$GenerationOptionsImpl) then) =
      __$$GenerationOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CardGenrationSize size, Model model, Language language});
}

/// @nodoc
class __$$GenerationOptionsImplCopyWithImpl<$Res>
    extends _$GenerationOptionsCopyWithImpl<$Res, _$GenerationOptionsImpl>
    implements _$$GenerationOptionsImplCopyWith<$Res> {
  __$$GenerationOptionsImplCopyWithImpl(_$GenerationOptionsImpl _value,
      $Res Function(_$GenerationOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = null,
    Object? model = null,
    Object? language = null,
  }) {
    return _then(_$GenerationOptionsImpl(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as CardGenrationSize,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
    ));
  }
}

/// @nodoc

class _$GenerationOptionsImpl extends _GenerationOptions {
  const _$GenerationOptionsImpl(
      {required this.size, required this.model, required this.language})
      : super._();

  @override
  final CardGenrationSize size;
  @override
  final Model model;
  @override
  final Language language;

  @override
  String toString() {
    return 'GenerationOptions(size: $size, model: $model, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerationOptionsImpl &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @override
  int get hashCode => Object.hash(runtimeType, size, model, language);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerationOptionsImplCopyWith<_$GenerationOptionsImpl> get copyWith =>
      __$$GenerationOptionsImplCopyWithImpl<_$GenerationOptionsImpl>(
          this, _$identity);
}

abstract class _GenerationOptions extends GenerationOptions {
  const factory _GenerationOptions(
      {required final CardGenrationSize size,
      required final Model model,
      required final Language language}) = _$GenerationOptionsImpl;
  const _GenerationOptions._() : super._();

  @override
  CardGenrationSize get size;
  @override
  Model get model;
  @override
  Language get language;
  @override
  @JsonKey(ignore: true)
  _$$GenerationOptionsImplCopyWith<_$GenerationOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
