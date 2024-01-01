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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  bool get hasPlus => throw _privateConstructorUsedError;
  Usage get usage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hasPlus, usage);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, generatedCardsCurrentMonth,
      generatedMnemonicsCurrentMonth, generatedCardsCurrentMonthByModel);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$UsageImplCopyWith<_$UsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsagePerMonthPerModel _$UsagePerMonthPerModelFromJson(
    Map<String, dynamic> json) {
  return _UsagePerMonthPerModel.fromJson(json);
}

/// @nodoc
mixin _$UsagePerMonthPerModel {
  @JsonKey(name: 'gpt-4-1106-preview')
  int get gpt4_1106Preview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsagePerMonthPerModelCopyWith<UsagePerMonthPerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsagePerMonthPerModelCopyWith<$Res> {
  factory $UsagePerMonthPerModelCopyWith(UsagePerMonthPerModel value,
          $Res Function(UsagePerMonthPerModel) then) =
      _$UsagePerMonthPerModelCopyWithImpl<$Res, UsagePerMonthPerModel>;
  @useResult
  $Res call({@JsonKey(name: 'gpt-4-1106-preview') int gpt4_1106Preview});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpt4_1106Preview = null,
  }) {
    return _then(_value.copyWith(
      gpt4_1106Preview: null == gpt4_1106Preview
          ? _value.gpt4_1106Preview
          : gpt4_1106Preview // ignore: cast_nullable_to_non_nullable
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
  $Res call({@JsonKey(name: 'gpt-4-1106-preview') int gpt4_1106Preview});
}

/// @nodoc
class __$$UsagePerMonthPerModelImplCopyWithImpl<$Res>
    extends _$UsagePerMonthPerModelCopyWithImpl<$Res,
        _$UsagePerMonthPerModelImpl>
    implements _$$UsagePerMonthPerModelImplCopyWith<$Res> {
  __$$UsagePerMonthPerModelImplCopyWithImpl(_$UsagePerMonthPerModelImpl _value,
      $Res Function(_$UsagePerMonthPerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gpt4_1106Preview = null,
  }) {
    return _then(_$UsagePerMonthPerModelImpl(
      gpt4_1106Preview: null == gpt4_1106Preview
          ? _value.gpt4_1106Preview
          : gpt4_1106Preview // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsagePerMonthPerModelImpl implements _UsagePerMonthPerModel {
  const _$UsagePerMonthPerModelImpl(
      {@JsonKey(name: 'gpt-4-1106-preview') this.gpt4_1106Preview = 0});

  factory _$UsagePerMonthPerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsagePerMonthPerModelImplFromJson(json);

  @override
  @JsonKey(name: 'gpt-4-1106-preview')
  final int gpt4_1106Preview;

  @override
  String toString() {
    return 'UsagePerMonthPerModel(gpt4_1106Preview: $gpt4_1106Preview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsagePerMonthPerModelImpl &&
            (identical(other.gpt4_1106Preview, gpt4_1106Preview) ||
                other.gpt4_1106Preview == gpt4_1106Preview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, gpt4_1106Preview);

  @JsonKey(ignore: true)
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
          {@JsonKey(name: 'gpt-4-1106-preview') final int gpt4_1106Preview}) =
      _$UsagePerMonthPerModelImpl;

  factory _UsagePerMonthPerModel.fromJson(Map<String, dynamic> json) =
      _$UsagePerMonthPerModelImpl.fromJson;

  @override
  @JsonKey(name: 'gpt-4-1106-preview')
  int get gpt4_1106Preview;
  @override
  @JsonKey(ignore: true)
  _$$UsagePerMonthPerModelImplCopyWith<_$UsagePerMonthPerModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
