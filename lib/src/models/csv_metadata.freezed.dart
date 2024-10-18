// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csv_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CsvMetadata _$CsvMetadataFromJson(Map<String, dynamic> json) {
  return _CsvMetadata.fromJson(json);
}

/// @nodoc
mixin _$CsvMetadata {
  String get downloadUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CsvMetadataCopyWith<CsvMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CsvMetadataCopyWith<$Res> {
  factory $CsvMetadataCopyWith(
          CsvMetadata value, $Res Function(CsvMetadata) then) =
      _$CsvMetadataCopyWithImpl<$Res, CsvMetadata>;
  @useResult
  $Res call({String downloadUrl});
}

/// @nodoc
class _$CsvMetadataCopyWithImpl<$Res, $Val extends CsvMetadata>
    implements $CsvMetadataCopyWith<$Res> {
  _$CsvMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadUrl = null,
  }) {
    return _then(_value.copyWith(
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CsvMetadataImplCopyWith<$Res>
    implements $CsvMetadataCopyWith<$Res> {
  factory _$$CsvMetadataImplCopyWith(
          _$CsvMetadataImpl value, $Res Function(_$CsvMetadataImpl) then) =
      __$$CsvMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String downloadUrl});
}

/// @nodoc
class __$$CsvMetadataImplCopyWithImpl<$Res>
    extends _$CsvMetadataCopyWithImpl<$Res, _$CsvMetadataImpl>
    implements _$$CsvMetadataImplCopyWith<$Res> {
  __$$CsvMetadataImplCopyWithImpl(
      _$CsvMetadataImpl _value, $Res Function(_$CsvMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadUrl = null,
  }) {
    return _then(_$CsvMetadataImpl(
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CsvMetadataImpl implements _CsvMetadata {
  const _$CsvMetadataImpl({required this.downloadUrl});

  factory _$CsvMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CsvMetadataImplFromJson(json);

  @override
  final String downloadUrl;

  @override
  String toString() {
    return 'CsvMetadata(downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CsvMetadataImpl &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, downloadUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CsvMetadataImplCopyWith<_$CsvMetadataImpl> get copyWith =>
      __$$CsvMetadataImplCopyWithImpl<_$CsvMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CsvMetadataImplToJson(
      this,
    );
  }
}

abstract class _CsvMetadata implements CsvMetadata {
  const factory _CsvMetadata({required final String downloadUrl}) =
      _$CsvMetadataImpl;

  factory _CsvMetadata.fromJson(Map<String, dynamic> json) =
      _$CsvMetadataImpl.fromJson;

  @override
  String get downloadUrl;
  @override
  @JsonKey(ignore: true)
  _$$CsvMetadataImplCopyWith<_$CsvMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
