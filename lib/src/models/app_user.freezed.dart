// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  bool get hasPlus => throw _privateConstructorUsedError;
  Usage get usage => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({bool hasPlus, Usage usage});

  $UsageCopyWith<$Res> get usage;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPlus = null,
    Object? usage = null,
  }) {
    return _then(_value.copyWith(
      hasPlus: null == hasPlus
          ? _value.hasPlus
          : hasPlus // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage,
    ) as $Val);
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsageCopyWith<$Res> get usage {
    return $UsageCopyWith<$Res>(_value.usage, (value) {
      return _then(_value.copyWith(usage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasPlus, Usage usage});

  @override
  $UsageCopyWith<$Res> get usage;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPlus = null,
    Object? usage = null,
  }) {
    return _then(_$AppUserImpl(
      hasPlus: null == hasPlus
          ? _value.hasPlus
          : hasPlus // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as Usage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl(
      {this.hasPlus = false,
      this.usage = const Usage(
          generatedCardsCurrentMonth: 0,
          generatedMnemonicsCurrentMonth: 0,
          generatedCardsCurrentMonthByModel: UsagePerMonthPerModel())})
      : super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  @JsonKey()
  final bool hasPlus;
  @override
  @JsonKey()
  final Usage usage;

  @override
  String toString() {
    return 'AppUser(hasPlus: $hasPlus, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.hasPlus, hasPlus) || other.hasPlus == hasPlus) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hasPlus, usage);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser({final bool hasPlus, final Usage usage}) =
      _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  bool get hasPlus;
  @override
  Usage get usage;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Usage _$UsageFromJson(Map<String, dynamic> json) {
  return _Usage.fromJson(json);
}

/// @nodoc
mixin _$Usage {
  int get generatedCardsCurrentMonth => throw _privateConstructorUsedError;
  int get generatedMnemonicsCurrentMonth => throw _privateConstructorUsedError;
  UsagePerMonthPerModel get generatedCardsCurrentMonthByModel =>
      throw _privateConstructorUsedError;

  /// Serializes this Usage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageCopyWith<Usage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageCopyWith<$Res> {
  factory $UsageCopyWith(Usage value, $Res Function(Usage) then) =
      _$UsageCopyWithImpl<$Res, Usage>;
  @useResult
  $Res call(
      {int generatedCardsCurrentMonth,
      int generatedMnemonicsCurrentMonth,
      UsagePerMonthPerModel generatedCardsCurrentMonthByModel});

  $UsagePerMonthPerModelCopyWith<$Res> get generatedCardsCurrentMonthByModel;
}

/// @nodoc
class _$UsageCopyWithImpl<$Res, $Val extends Usage>
    implements $UsageCopyWith<$Res> {
  _$UsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generatedCardsCurrentMonth = null,
    Object? generatedMnemonicsCurrentMonth = null,
    Object? generatedCardsCurrentMonthByModel = null,
  }) {
    return _then(_value.copyWith(
      generatedCardsCurrentMonth: null == generatedCardsCurrentMonth
          ? _value.generatedCardsCurrentMonth
          : generatedCardsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      generatedMnemonicsCurrentMonth: null == generatedMnemonicsCurrentMonth
          ? _value.generatedMnemonicsCurrentMonth
          : generatedMnemonicsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      generatedCardsCurrentMonthByModel: null ==
              generatedCardsCurrentMonthByModel
          ? _value.generatedCardsCurrentMonthByModel
          : generatedCardsCurrentMonthByModel // ignore: cast_nullable_to_non_nullable
              as UsagePerMonthPerModel,
    ) as $Val);
  }

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UsagePerMonthPerModelCopyWith<$Res> get generatedCardsCurrentMonthByModel {
    return $UsagePerMonthPerModelCopyWith<$Res>(
        _value.generatedCardsCurrentMonthByModel, (value) {
      return _then(
          _value.copyWith(generatedCardsCurrentMonthByModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UsageImplCopyWith<$Res> implements $UsageCopyWith<$Res> {
  factory _$$UsageImplCopyWith(
          _$UsageImpl value, $Res Function(_$UsageImpl) then) =
      __$$UsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int generatedCardsCurrentMonth,
      int generatedMnemonicsCurrentMonth,
      UsagePerMonthPerModel generatedCardsCurrentMonthByModel});

  @override
  $UsagePerMonthPerModelCopyWith<$Res> get generatedCardsCurrentMonthByModel;
}

/// @nodoc
class __$$UsageImplCopyWithImpl<$Res>
    extends _$UsageCopyWithImpl<$Res, _$UsageImpl>
    implements _$$UsageImplCopyWith<$Res> {
  __$$UsageImplCopyWithImpl(
      _$UsageImpl _value, $Res Function(_$UsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generatedCardsCurrentMonth = null,
    Object? generatedMnemonicsCurrentMonth = null,
    Object? generatedCardsCurrentMonthByModel = null,
  }) {
    return _then(_$UsageImpl(
      generatedCardsCurrentMonth: null == generatedCardsCurrentMonth
          ? _value.generatedCardsCurrentMonth
          : generatedCardsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      generatedMnemonicsCurrentMonth: null == generatedMnemonicsCurrentMonth
          ? _value.generatedMnemonicsCurrentMonth
          : generatedMnemonicsCurrentMonth // ignore: cast_nullable_to_non_nullable
              as int,
      generatedCardsCurrentMonthByModel: null ==
              generatedCardsCurrentMonthByModel
          ? _value.generatedCardsCurrentMonthByModel
          : generatedCardsCurrentMonthByModel // ignore: cast_nullable_to_non_nullable
              as UsagePerMonthPerModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageImpl implements _Usage {
  const _$UsageImpl(
      {this.generatedCardsCurrentMonth = 0,
      this.generatedMnemonicsCurrentMonth = 0,
      this.generatedCardsCurrentMonthByModel = const UsagePerMonthPerModel()});

  factory _$UsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageImplFromJson(json);

  @override
  @JsonKey()
  final int generatedCardsCurrentMonth;
  @override
  @JsonKey()
  final int generatedMnemonicsCurrentMonth;
  @override
  @JsonKey()
  final UsagePerMonthPerModel generatedCardsCurrentMonthByModel;

  @override
  String toString() {
    return 'Usage(generatedCardsCurrentMonth: $generatedCardsCurrentMonth, generatedMnemonicsCurrentMonth: $generatedMnemonicsCurrentMonth, generatedCardsCurrentMonthByModel: $generatedCardsCurrentMonthByModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageImpl &&
            (identical(other.generatedCardsCurrentMonth,
                    generatedCardsCurrentMonth) ||
                other.generatedCardsCurrentMonth ==
                    generatedCardsCurrentMonth) &&
            (identical(other.generatedMnemonicsCurrentMonth,
                    generatedMnemonicsCurrentMonth) ||
                other.generatedMnemonicsCurrentMonth ==
                    generatedMnemonicsCurrentMonth) &&
            (identical(other.generatedCardsCurrentMonthByModel,
                    generatedCardsCurrentMonthByModel) ||
                other.generatedCardsCurrentMonthByModel ==
                    generatedCardsCurrentMonthByModel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generatedCardsCurrentMonth,
      generatedMnemonicsCurrentMonth, generatedCardsCurrentMonthByModel);

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageImplCopyWith<_$UsageImpl> get copyWith =>
      __$$UsageImplCopyWithImpl<_$UsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageImplToJson(
      this,
    );
  }
}

abstract class _Usage implements Usage {
  const factory _Usage(
          {final int generatedCardsCurrentMonth,
          final int generatedMnemonicsCurrentMonth,
          final UsagePerMonthPerModel generatedCardsCurrentMonthByModel}) =
      _$UsageImpl;

  factory _Usage.fromJson(Map<String, dynamic> json) = _$UsageImpl.fromJson;

  @override
  int get generatedCardsCurrentMonth;
  @override
  int get generatedMnemonicsCurrentMonth;
  @override
  UsagePerMonthPerModel get generatedCardsCurrentMonthByModel;

  /// Create a copy of Usage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageImplCopyWith<_$UsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsagePerMonthPerModel _$UsagePerMonthPerModelFromJson(
    Map<String, dynamic> json) {
  return _UsagePerMonthPerModel.fromJson(json);
}

/// @nodoc
mixin _$UsagePerMonthPerModel {
  @JsonKey(name: 'gpt-4')
  int get gpt4 => throw _privateConstructorUsedError;

  /// Serializes this UsagePerMonthPerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsagePerMonthPerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsagePerMonthPerModelCopyWith<UsagePerMonthPerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsagePerMonthPerModelCopyWith<$Res> {
  factory $UsagePerMonthPerModelCopyWith(UsagePerMonthPerModel value,
          $Res Function(UsagePerMonthPerModel) then) =
      _$UsagePerMonthPerModelCopyWithImpl<$Res, UsagePerMonthPerModel>;
  @useResult
  $Res call({@JsonKey(name: 'gpt-4') int gpt4});
}

/// @nodoc
class _$UsagePerMonthPerModelCopyWithImpl<$Res,
        $Val extends UsagePerMonthPerModel>
    implements $UsagePerMonthPerModelCopyWith<$Res> {
  _$UsagePerMonthPerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsagePerMonthPerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpt4 = null,
  }) {
    return _then(_value.copyWith(
      gpt4: null == gpt4
          ? _value.gpt4
          : gpt4 // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsagePerMonthPerModelImplCopyWith<$Res>
    implements $UsagePerMonthPerModelCopyWith<$Res> {
  factory _$$UsagePerMonthPerModelImplCopyWith(
          _$UsagePerMonthPerModelImpl value,
          $Res Function(_$UsagePerMonthPerModelImpl) then) =
      __$$UsagePerMonthPerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'gpt-4') int gpt4});
}

/// @nodoc
class __$$UsagePerMonthPerModelImplCopyWithImpl<$Res>
    extends _$UsagePerMonthPerModelCopyWithImpl<$Res,
        _$UsagePerMonthPerModelImpl>
    implements _$$UsagePerMonthPerModelImplCopyWith<$Res> {
  __$$UsagePerMonthPerModelImplCopyWithImpl(_$UsagePerMonthPerModelImpl _value,
      $Res Function(_$UsagePerMonthPerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsagePerMonthPerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpt4 = null,
  }) {
    return _then(_$UsagePerMonthPerModelImpl(
      gpt4: null == gpt4
          ? _value.gpt4
          : gpt4 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsagePerMonthPerModelImpl implements _UsagePerMonthPerModel {
  const _$UsagePerMonthPerModelImpl({@JsonKey(name: 'gpt-4') this.gpt4 = 0});

  factory _$UsagePerMonthPerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsagePerMonthPerModelImplFromJson(json);

  @override
  @JsonKey(name: 'gpt-4')
  final int gpt4;

  @override
  String toString() {
    return 'UsagePerMonthPerModel(gpt4: $gpt4)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsagePerMonthPerModelImpl &&
            (identical(other.gpt4, gpt4) || other.gpt4 == gpt4));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, gpt4);

  /// Create a copy of UsagePerMonthPerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsagePerMonthPerModelImplCopyWith<_$UsagePerMonthPerModelImpl>
      get copyWith => __$$UsagePerMonthPerModelImplCopyWithImpl<
          _$UsagePerMonthPerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsagePerMonthPerModelImplToJson(
      this,
    );
  }
}

abstract class _UsagePerMonthPerModel implements UsagePerMonthPerModel {
  const factory _UsagePerMonthPerModel(
      {@JsonKey(name: 'gpt-4') final int gpt4}) = _$UsagePerMonthPerModelImpl;

  factory _UsagePerMonthPerModel.fromJson(Map<String, dynamic> json) =
      _$UsagePerMonthPerModelImpl.fromJson;

  @override
  @JsonKey(name: 'gpt-4')
  int get gpt4;

  /// Create a copy of UsagePerMonthPerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsagePerMonthPerModelImplCopyWith<_$UsagePerMonthPerModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
