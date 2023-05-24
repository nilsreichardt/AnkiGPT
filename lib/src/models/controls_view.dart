import 'package:freezed_annotation/freezed_annotation.dart';

part 'controls_view.freezed.dart';

@freezed
class ControlsView with _$ControlsView {
  const factory ControlsView({
    required bool isGeneratedButtonEnabled,
    required bool isGenerating,
  }) = _ControlsView;
}
