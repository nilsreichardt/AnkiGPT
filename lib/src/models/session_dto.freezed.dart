// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) {
  return _SessionDto.fromJson(json);
}

/// @nodoc
mixin _$SessionDto {
  String get id => throw _privateConstructorUsedError;
  Language? get language => throw _privateConstructorUsedError;
  Input get input => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseTimestamp)
  DateTime get createdAt => throw _privateConstructorUsedError;
  CsvMetadata? get csv => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseCards)
  Map<String, AnkiCard>? get cards => throw _privateConstructorUsedError;
  SessionStatus get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseError)
  String? get error => throw _privateConstructorUsedError;
  int get numberOfCards => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseVisibility)
  Visibility get visibility => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseModel)
  Model get model => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionDtoCopyWith<SessionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionDtoCopyWith<$Res> {
  factory $SessionDtoCopyWith(
          SessionDto value, $Res Function(SessionDto) then) =
      _$SessionDtoCopyWithImpl<$Res, SessionDto>;
  @useResult
  $Res call(
      {String id,
      Language? language,
      Input input,
      @JsonKey(fromJson: parseTimestamp) DateTime createdAt,
      CsvMetadata? csv,
      @JsonKey(fromJson: parseCards) Map<String, AnkiCard>? cards,
      SessionStatus status,
      @JsonKey(fromJson: parseError) String? error,
      int numberOfCards,
      @JsonKey(fromJson: parseVisibility) Visibility visibility,
      String userId,
      @JsonKey(fromJson: parseModel) Model model,
      String? title});

  $InputCopyWith<$Res> get input;
  $CsvMetadataCopyWith<$Res>? get csv;
}

/// @nodoc
class _$SessionDtoCopyWithImpl<$Res, $Val extends SessionDto>
    implements $SessionDtoCopyWith<$Res> {
  _$SessionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = freezed,
    Object? input = null,
    Object? createdAt = null,
    Object? csv = freezed,
    Object? cards = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? numberOfCards = null,
    Object? visibility = null,
    Object? userId = null,
    Object? model = null,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as Input,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      csv: freezed == csv
          ? _value.csv
          : csv // ignore: cast_nullable_to_non_nullable
              as CsvMetadata?,
      cards: freezed == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as Map<String, AnkiCard>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as Visibility,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InputCopyWith<$Res> get input {
    return $InputCopyWith<$Res>(_value.input, (value) {
      return _then(_value.copyWith(input: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CsvMetadataCopyWith<$Res>? get csv {
    if (_value.csv == null) {
      return null;
    }

    return $CsvMetadataCopyWith<$Res>(_value.csv!, (value) {
      return _then(_value.copyWith(csv: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionDtoImplCopyWith<$Res>
    implements $SessionDtoCopyWith<$Res> {
  factory _$$SessionDtoImplCopyWith(
          _$SessionDtoImpl value, $Res Function(_$SessionDtoImpl) then) =
      __$$SessionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Language? language,
      Input input,
      @JsonKey(fromJson: parseTimestamp) DateTime createdAt,
      CsvMetadata? csv,
      @JsonKey(fromJson: parseCards) Map<String, AnkiCard>? cards,
      SessionStatus status,
      @JsonKey(fromJson: parseError) String? error,
      int numberOfCards,
      @JsonKey(fromJson: parseVisibility) Visibility visibility,
      String userId,
      @JsonKey(fromJson: parseModel) Model model,
      String? title});

  @override
  $InputCopyWith<$Res> get input;
  @override
  $CsvMetadataCopyWith<$Res>? get csv;
}

/// @nodoc
class __$$SessionDtoImplCopyWithImpl<$Res>
    extends _$SessionDtoCopyWithImpl<$Res, _$SessionDtoImpl>
    implements _$$SessionDtoImplCopyWith<$Res> {
  __$$SessionDtoImplCopyWithImpl(
      _$SessionDtoImpl _value, $Res Function(_$SessionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = freezed,
    Object? input = null,
    Object? createdAt = null,
    Object? csv = freezed,
    Object? cards = freezed,
    Object? status = null,
    Object? error = freezed,
    Object? numberOfCards = null,
    Object? visibility = null,
    Object? userId = null,
    Object? model = null,
    Object? title = freezed,
  }) {
    return _then(_$SessionDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language?,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as Input,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      csv: freezed == csv
          ? _value.csv
          : csv // ignore: cast_nullable_to_non_nullable
              as CsvMetadata?,
      cards: freezed == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as Map<String, AnkiCard>?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as Visibility,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as Model,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionDtoImpl implements _SessionDto {
  const _$SessionDtoImpl(
      {required this.id,
      required this.language,
      required this.input,
      @JsonKey(fromJson: parseTimestamp) required this.createdAt,
      required this.csv,
      @JsonKey(fromJson: parseCards)
      required final Map<String, AnkiCard>? cards,
      required this.status,
      @JsonKey(fromJson: parseError) this.error,
      required this.numberOfCards,
      @JsonKey(fromJson: parseVisibility) required this.visibility,
      required this.userId,
      @JsonKey(fromJson: parseModel) required this.model,
      required this.title})
      : _cards = cards;

  factory _$SessionDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionDtoImplFromJson(json);

  @override
  final String id;
  @override
  final Language? language;
  @override
  final Input input;
  @override
  @JsonKey(fromJson: parseTimestamp)
  final DateTime createdAt;
  @override
  final CsvMetadata? csv;
  final Map<String, AnkiCard>? _cards;
  @override
  @JsonKey(fromJson: parseCards)
  Map<String, AnkiCard>? get cards {
    final value = _cards;
    if (value == null) return null;
    if (_cards is EqualUnmodifiableMapView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final SessionStatus status;
  @override
  @JsonKey(fromJson: parseError)
  final String? error;
  @override
  final int numberOfCards;
  @override
  @JsonKey(fromJson: parseVisibility)
  final Visibility visibility;
  @override
  final String userId;
  @override
  @JsonKey(fromJson: parseModel)
  final Model model;
  @override
  final String? title;

  @override
  String toString() {
    return 'SessionDto(id: $id, language: $language, input: $input, createdAt: $createdAt, csv: $csv, cards: $cards, status: $status, error: $error, numberOfCards: $numberOfCards, visibility: $visibility, userId: $userId, model: $model, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.csv, csv) || other.csv == csv) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      language,
      input,
      createdAt,
      csv,
      const DeepCollectionEquality().hash(_cards),
      status,
      error,
      numberOfCards,
      visibility,
      userId,
      model,
      title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionDtoImplCopyWith<_$SessionDtoImpl> get copyWith =>
      __$$SessionDtoImplCopyWithImpl<_$SessionDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionDtoImplToJson(
      this,
    );
  }
}

abstract class _SessionDto implements SessionDto {
  const factory _SessionDto(
      {required final String id,
      required final Language? language,
      required final Input input,
      @JsonKey(fromJson: parseTimestamp) required final DateTime createdAt,
      required final CsvMetadata? csv,
      @JsonKey(fromJson: parseCards)
      required final Map<String, AnkiCard>? cards,
      required final SessionStatus status,
      @JsonKey(fromJson: parseError) final String? error,
      required final int numberOfCards,
      @JsonKey(fromJson: parseVisibility) required final Visibility visibility,
      required final String userId,
      @JsonKey(fromJson: parseModel) required final Model model,
      required final String? title}) = _$SessionDtoImpl;

  factory _SessionDto.fromJson(Map<String, dynamic> json) =
      _$SessionDtoImpl.fromJson;

  @override
  String get id;
  @override
  Language? get language;
  @override
  Input get input;
  @override
  @JsonKey(fromJson: parseTimestamp)
  DateTime get createdAt;
  @override
  CsvMetadata? get csv;
  @override
  @JsonKey(fromJson: parseCards)
  Map<String, AnkiCard>? get cards;
  @override
  SessionStatus get status;
  @override
  @JsonKey(fromJson: parseError)
  String? get error;
  @override
  int get numberOfCards;
  @override
  @JsonKey(fromJson: parseVisibility)
  Visibility get visibility;
  @override
  String get userId;
  @override
  @JsonKey(fromJson: parseModel)
  Model get model;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$SessionDtoImplCopyWith<_$SessionDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Input _$InputFromJson(Map<String, dynamic> json) {
  return _Input.fromJson(json);
}

/// @nodoc
mixin _$Input {
  String? get text => throw _privateConstructorUsedError;
  InputType get type => throw _privateConstructorUsedError;
  FileInput? get file => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InputCopyWith<Input> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputCopyWith<$Res> {
  factory $InputCopyWith(Input value, $Res Function(Input) then) =
      _$InputCopyWithImpl<$Res, Input>;
  @useResult
  $Res call({String? text, InputType type, FileInput? file});

  $FileInputCopyWith<$Res>? get file;
}

/// @nodoc
class _$InputCopyWithImpl<$Res, $Val extends Input>
    implements $InputCopyWith<$Res> {
  _$InputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? type = null,
    Object? file = freezed,
  }) {
    return _then(_value.copyWith(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InputType,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as FileInput?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FileInputCopyWith<$Res>? get file {
    if (_value.file == null) {
      return null;
    }

    return $FileInputCopyWith<$Res>(_value.file!, (value) {
      return _then(_value.copyWith(file: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InputImplCopyWith<$Res> implements $InputCopyWith<$Res> {
  factory _$$InputImplCopyWith(
          _$InputImpl value, $Res Function(_$InputImpl) then) =
      __$$InputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, InputType type, FileInput? file});

  @override
  $FileInputCopyWith<$Res>? get file;
}

/// @nodoc
class __$$InputImplCopyWithImpl<$Res>
    extends _$InputCopyWithImpl<$Res, _$InputImpl>
    implements _$$InputImplCopyWith<$Res> {
  __$$InputImplCopyWithImpl(
      _$InputImpl _value, $Res Function(_$InputImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? type = null,
    Object? file = freezed,
  }) {
    return _then(_$InputImpl(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InputType,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as FileInput?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InputImpl extends _Input {
  const _$InputImpl(
      {required this.text, required this.type, required this.file})
      : super._();

  factory _$InputImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputImplFromJson(json);

  @override
  final String? text;
  @override
  final InputType type;
  @override
  final FileInput? file;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, type, file);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputImplCopyWith<_$InputImpl> get copyWith =>
      __$$InputImplCopyWithImpl<_$InputImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputImplToJson(
      this,
    );
  }
}

abstract class _Input extends Input {
  const factory _Input(
      {required final String? text,
      required final InputType type,
      required final FileInput? file}) = _$InputImpl;
  const _Input._() : super._();

  factory _Input.fromJson(Map<String, dynamic> json) = _$InputImpl.fromJson;

  @override
  String? get text;
  @override
  InputType get type;
  @override
  FileInput? get file;
  @override
  @JsonKey(ignore: true)
  _$$InputImplCopyWith<_$InputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FileInput _$FileInputFromJson(Map<String, dynamic> json) {
  return _FileInput.fromJson(json);
}

/// @nodoc
mixin _$FileInput {
  String get name => throw _privateConstructorUsedError;
  String? get pdfPassword => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileInputCopyWith<FileInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileInputCopyWith<$Res> {
  factory $FileInputCopyWith(FileInput value, $Res Function(FileInput) then) =
      _$FileInputCopyWithImpl<$Res, FileInput>;
  @useResult
  $Res call({String name, String? pdfPassword});
}

/// @nodoc
class _$FileInputCopyWithImpl<$Res, $Val extends FileInput>
    implements $FileInputCopyWith<$Res> {
  _$FileInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? pdfPassword = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pdfPassword: freezed == pdfPassword
          ? _value.pdfPassword
          : pdfPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FileInputImplCopyWith<$Res>
    implements $FileInputCopyWith<$Res> {
  factory _$$FileInputImplCopyWith(
          _$FileInputImpl value, $Res Function(_$FileInputImpl) then) =
      __$$FileInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? pdfPassword});
}

/// @nodoc
class __$$FileInputImplCopyWithImpl<$Res>
    extends _$FileInputCopyWithImpl<$Res, _$FileInputImpl>
    implements _$$FileInputImplCopyWith<$Res> {
  __$$FileInputImplCopyWithImpl(
      _$FileInputImpl _value, $Res Function(_$FileInputImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? pdfPassword = freezed,
  }) {
    return _then(_$FileInputImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pdfPassword: freezed == pdfPassword
          ? _value.pdfPassword
          : pdfPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileInputImpl implements _FileInput {
  const _$FileInputImpl({required this.name, this.pdfPassword});

  factory _$FileInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileInputImplFromJson(json);

  @override
  final String name;
  @override
  final String? pdfPassword;

  @override
  String toString() {
    return 'FileInput(name: $name, pdfPassword: $pdfPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileInputImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pdfPassword, pdfPassword) ||
                other.pdfPassword == pdfPassword));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, pdfPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileInputImplCopyWith<_$FileInputImpl> get copyWith =>
      __$$FileInputImplCopyWithImpl<_$FileInputImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FileInputImplToJson(
      this,
    );
  }
}

abstract class _FileInput implements FileInput {
  const factory _FileInput(
      {required final String name,
      final String? pdfPassword}) = _$FileInputImpl;

  factory _FileInput.fromJson(Map<String, dynamic> json) =
      _$FileInputImpl.fromJson;

  @override
  String get name;
  @override
  String? get pdfPassword;
  @override
  @JsonKey(ignore: true)
  _$$FileInputImplCopyWith<_$FileInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
