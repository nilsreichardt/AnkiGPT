import 'package:ankigpt/src/models/language.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_view.freezed.dart';

@freezed
class WatchView with _$WatchView {
  const WatchView._();

  const factory WatchView({
    @Default(false) bool isLoading,
    String? downloadUrl,
    Language? language,
    String? error,
    String? fileName,
    SessionId? sessionId,
  }) = _WatchView;

  bool get hasFile => fileName != null;
  bool get hasError => error != null;
  bool get isDownloadAvailable => downloadUrl != null;
  String get downloadButtonTooltip {
    if (isLoading) {
      return 'Still generating... Please wait.';
    }

    if (isDownloadAvailable) {
      return 'Download as .csv file to import it';
    }

    return '';
  }
}
