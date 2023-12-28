// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cards_list_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$CardsListViewImplCopyWith<$Res>
    implements $CardsListViewCopyWith<$Res> {
  factory _$$CardsListViewImplCopyWith(
          _$CardsListViewImpl value, $Res Function(_$CardsListViewImpl) then) =
      __$$CardsListViewImplCopyWithImpl<$Res>;
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
class __$$CardsListViewImplCopyWithImpl<$Res>
    extends _$CardsListViewCopyWithImpl<$Res, _$CardsListViewImpl>
    implements _$$CardsListViewImplCopyWith<$Res> {
  __$$CardsListViewImplCopyWithImpl(
      _$CardsListViewImpl _value, $Res Function(_$CardsListViewImpl) _then)
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
    return _then(_$CardsListViewImpl(
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

class _$CardsListViewImpl extends _CardsListView {
  const _$CardsListViewImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardsListViewImpl &&
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
  _$$CardsListViewImplCopyWith<_$CardsListViewImpl> get copyWith =>
      __$$CardsListViewImplCopyWithImpl<_$CardsListViewImpl>(this, _$identity);
}

abstract class _CardsListView extends CardsListView {
  const factory _CardsListView(
      {required final List<AnkiCard> cards,
      required final int currentPage,
      required final int totalPages,
      required final bool canPressNext,
      required final bool canPressPrevious}) = _$CardsListViewImpl;
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
  _$$CardsListViewImplCopyWith<_$CardsListViewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
