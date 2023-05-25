import 'package:freezed_annotation/freezed_annotation.dart';

part 'csv_metadata.freezed.dart';
part 'csv_metadata.g.dart';

@Freezed(fromJson: true)
class CsvMetadata with _$CsvMetadata {
  const factory CsvMetadata({
    required String downloadUrl,
  }) = _CsvMetadata;

  factory CsvMetadata.fromJson(Map<String, dynamic> json) =>
      _$CsvMetadataFromJson(json);
}
