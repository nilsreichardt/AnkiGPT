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
  bool get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(fromJson: parseError)
  String? get error => throw _privateConstructorUsedError;
  int get numberOfCards => throw _privateConstructorUsedError;

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
      bool isCompleted,
      @JsonKey(fromJson: parseError) String? error,
      int numberOfCards});

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
    Object? isCompleted = null,
    Object? error = freezed,
    Object? numberOfCards = null,
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
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$_SessionDtoCopyWith<$Res>
    implements $SessionDtoCopyWith<$Res> {
  factory _$$_SessionDtoCopyWith(
          _$_SessionDto value, $Res Function(_$_SessionDto) then) =
      __$$_SessionDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Language? language,
      Input input,
      @JsonKey(fromJson: parseTimestamp) DateTime createdAt,
      CsvMetadata? csv,
      @JsonKey(fromJson: parseCards) Map<String, AnkiCard>? cards,
      bool isCompleted,
      @JsonKey(fromJson: parseError) String? error,
      int numberOfCards});

  @override
  $InputCopyWith<$Res> get input;
  @override
  $CsvMetadataCopyWith<$Res>? get csv;
}

/// @nodoc
class __$$_SessionDtoCopyWithImpl<$Res>
    extends _$SessionDtoCopyWithImpl<$Res, _$_SessionDto>
    implements _$$_SessionDtoCopyWith<$Res> {
  __$$_SessionDtoCopyWithImpl(
      _$_SessionDto _value, $Res Function(_$_SessionDto) _then)
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
    Object? isCompleted = null,
    Object? error = freezed,
    Object? numberOfCards = null,
  }) {
    return _then(_$_SessionDto(
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
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfCards: null == numberOfCards
          ? _value.numberOfCards
          : numberOfCards // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SessionDto implements _SessionDto {
  const _$_SessionDto(
      {required this.id,
      required this.language,
      required this.input,
      @JsonKey(fromJson: parseTimestamp)
          required this.createdAt,
      required this.csv,
      @JsonKey(fromJson: parseCards)
          required final Map<String, AnkiCard>? cards,
      this.isCompleted = false,
      @JsonKey(fromJson: parseError)
          this.error,
      required this.numberOfCards})
      : _cards = cards;

  factory _$_SessionDto.fromJson(Map<String, dynamic> json) =>
      _$$_SessionDtoFromJson(json);

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
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey(fromJson: parseError)
  final String? error;
  @override
  final int numberOfCards;

  @override
  String toString() {
    return 'SessionDto(id: $id, language: $language, input: $input, createdAt: $createdAt, csv: $csv, cards: $cards, isCompleted: $isCompleted, error: $error, numberOfCards: $numberOfCards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.csv, csv) || other.csv == csv) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.numberOfCards, numberOfCards) ||
                other.numberOfCards == numberOfCards));
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
      isCompleted,
      error,
      numberOfCards);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionDtoCopyWith<_$_SessionDto> get copyWith =>
      __$$_SessionDtoCopyWithImpl<_$_SessionDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionDtoToJson(
      this,
    );
  }
}

abstract class _SessionDto implements SessionDto {
  const factory _SessionDto(
      {required final String id,
      required final Language? language,
      required final Input input,
      @JsonKey(fromJson: parseTimestamp)
          required final DateTime createdAt,
      required final CsvMetadata? csv,
      @JsonKey(fromJson: parseCards)
          required final Map<String, AnkiCard>? cards,
      final bool isCompleted,
      @JsonKey(fromJson: parseError)
          final String? error,
      required final int numberOfCards}) = _$_SessionDto;

  factory _SessionDto.fromJson(Map<String, dynamic> json) =
      _$_SessionDto.fromJson;

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
  bool get isCompleted;
  @override
  @JsonKey(fromJson: parseError)
  String? get error;
  @override
  int get numberOfCards;
  @override
  @JsonKey(ignore: true)
  _$$_SessionDtoCopyWith<_$_SessionDto> get copyWith =>
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
abstract class _$$_InputCopyWith<$Res> implements $InputCopyWith<$Res> {
  factory _$$_InputCopyWith(_$_Input value, $Res Function(_$_Input) then) =
      __$$_InputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, InputType type, FileInput? file});

  @override
  $FileInputCopyWith<$Res>? get file;
}

/// @nodoc
class __$$_InputCopyWithImpl<$Res> extends _$InputCopyWithImpl<$Res, _$_Input>
    implements _$$_InputCopyWith<$Res> {
  __$$_InputCopyWithImpl(_$_Input _value, $Res Function(_$_Input) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? type = null,
    Object? file = freezed,
  }) {
    return _then(_$_Input(
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
class _$_Input implements _Input {
  const _$_Input({required this.text, required this.type, required this.file});

  factory _$_Input.fromJson(Map<String, dynamic> json) =>
      _$$_InputFromJson(json);

  @override
  final String? text;
  @override
  final InputType type;
  @override
  final FileInput? file;

  @override
  String toString() {
    return 'Input(text: $text, type: $type, file: $file)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Input &&
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
  _$$_InputCopyWith<_$_Input> get copyWith =>
      __$$_InputCopyWithImpl<_$_Input>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InputToJson(
      this,
    );
  }
}

abstract class _Input implements Input {
  const factory _Input(
      {required final String? text,
      required final InputType type,
      required final FileInput? file}) = _$_Input;

  factory _Input.fromJson(Map<String, dynamic> json) = _$_Input.fromJson;

  @override
  String? get text;
  @override
  InputType get type;
  @override
  FileInput? get file;
  @override
  @JsonKey(ignore: true)
  _$$_InputCopyWith<_$_Input> get copyWith =>
      throw _privateConstructorUsedError;
}

FileInput _$FileInputFromJson(Map<String, dynamic> json) {
  return _FileInput.fromJson(json);
}

/// @nodoc
mixin _$FileInput {
  String get name => throw _privateConstructorUsedError;

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
  $Res call({String name});
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
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileInputCopyWith<$Res> implements $FileInputCopyWith<$Res> {
  factory _$$_FileInputCopyWith(
          _$_FileInput value, $Res Function(_$_FileInput) then) =
      __$$_FileInputCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_FileInputCopyWithImpl<$Res>
    extends _$FileInputCopyWithImpl<$Res, _$_FileInput>
    implements _$$_FileInputCopyWith<$Res> {
  __$$_FileInputCopyWithImpl(
      _$_FileInput _value, $Res Function(_$_FileInput) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_FileInput(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FileInput implements _FileInput {
  const _$_FileInput({required this.name});

  factory _$_FileInput.fromJson(Map<String, dynamic> json) =>
      _$$_FileInputFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'FileInput(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileInput &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileInputCopyWith<_$_FileInput> get copyWith =>
      __$$_FileInputCopyWithImpl<_$_FileInput>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileInputToJson(
      this,
    );
  }
}

abstract class _FileInput implements FileInput {
  const factory _FileInput({required final String name}) = _$_FileInput;

  factory _FileInput.fromJson(Map<String, dynamic> json) =
      _$_FileInput.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_FileInputCopyWith<_$_FileInput> get copyWith =>
      throw _privateConstructorUsedError;
}
