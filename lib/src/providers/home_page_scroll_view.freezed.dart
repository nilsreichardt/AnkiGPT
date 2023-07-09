// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_scroll_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePageScrollViewData {
  GlobalKey<State<StatefulWidget>> get inputSectionKey =>
      throw _privateConstructorUsedError;
  GlobalKey<State<StatefulWidget>> get pricingSectionKey =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePageScrollViewDataCopyWith<HomePageScrollViewData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageScrollViewDataCopyWith<$Res> {
  factory $HomePageScrollViewDataCopyWith(HomePageScrollViewData value,
          $Res Function(HomePageScrollViewData) then) =
      _$HomePageScrollViewDataCopyWithImpl<$Res, HomePageScrollViewData>;
  @useResult
  $Res call(
      {GlobalKey<State<StatefulWidget>> inputSectionKey,
      GlobalKey<State<StatefulWidget>> pricingSectionKey});
}

/// @nodoc
class _$HomePageScrollViewDataCopyWithImpl<$Res,
        $Val extends HomePageScrollViewData>
    implements $HomePageScrollViewDataCopyWith<$Res> {
  _$HomePageScrollViewDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputSectionKey = null,
    Object? pricingSectionKey = null,
  }) {
    return _then(_value.copyWith(
      inputSectionKey: null == inputSectionKey
          ? _value.inputSectionKey
          : inputSectionKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>,
      pricingSectionKey: null == pricingSectionKey
          ? _value.pricingSectionKey
          : pricingSectionKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomePageScrollViewDataCopyWith<$Res>
    implements $HomePageScrollViewDataCopyWith<$Res> {
  factory _$$_HomePageScrollViewDataCopyWith(_$_HomePageScrollViewData value,
          $Res Function(_$_HomePageScrollViewData) then) =
      __$$_HomePageScrollViewDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GlobalKey<State<StatefulWidget>> inputSectionKey,
      GlobalKey<State<StatefulWidget>> pricingSectionKey});
}

/// @nodoc
class __$$_HomePageScrollViewDataCopyWithImpl<$Res>
    extends _$HomePageScrollViewDataCopyWithImpl<$Res,
        _$_HomePageScrollViewData>
    implements _$$_HomePageScrollViewDataCopyWith<$Res> {
  __$$_HomePageScrollViewDataCopyWithImpl(_$_HomePageScrollViewData _value,
      $Res Function(_$_HomePageScrollViewData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputSectionKey = null,
    Object? pricingSectionKey = null,
  }) {
    return _then(_$_HomePageScrollViewData(
      inputSectionKey: null == inputSectionKey
          ? _value.inputSectionKey
          : inputSectionKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>,
      pricingSectionKey: null == pricingSectionKey
          ? _value.pricingSectionKey
          : pricingSectionKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<State<StatefulWidget>>,
    ));
  }
}

/// @nodoc

class _$_HomePageScrollViewData implements _HomePageScrollViewData {
  const _$_HomePageScrollViewData(
      {required this.inputSectionKey, required this.pricingSectionKey});

  @override
  final GlobalKey<State<StatefulWidget>> inputSectionKey;
  @override
  final GlobalKey<State<StatefulWidget>> pricingSectionKey;

  @override
  String toString() {
    return 'HomePageScrollViewData(inputSectionKey: $inputSectionKey, pricingSectionKey: $pricingSectionKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomePageScrollViewData &&
            (identical(other.inputSectionKey, inputSectionKey) ||
                other.inputSectionKey == inputSectionKey) &&
            (identical(other.pricingSectionKey, pricingSectionKey) ||
                other.pricingSectionKey == pricingSectionKey));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, inputSectionKey, pricingSectionKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomePageScrollViewDataCopyWith<_$_HomePageScrollViewData> get copyWith =>
      __$$_HomePageScrollViewDataCopyWithImpl<_$_HomePageScrollViewData>(
          this, _$identity);
}

abstract class _HomePageScrollViewData implements HomePageScrollViewData {
  const factory _HomePageScrollViewData(
          {required final GlobalKey<State<StatefulWidget>> inputSectionKey,
          required final GlobalKey<State<StatefulWidget>> pricingSectionKey}) =
      _$_HomePageScrollViewData;

  @override
  GlobalKey<State<StatefulWidget>> get inputSectionKey;
  @override
  GlobalKey<State<StatefulWidget>> get pricingSectionKey;
  @override
  @JsonKey(ignore: true)
  _$$_HomePageScrollViewDataCopyWith<_$_HomePageScrollViewData> get copyWith =>
      throw _privateConstructorUsedError;
}
