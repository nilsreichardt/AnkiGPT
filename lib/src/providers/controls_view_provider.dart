import 'package:ankigpt/src/models/controls_view.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final controlsViewProvider = Provider<ControlsView>(
  (ref) {
    final generateState = ref.watch(generateStateProvider);
    return generateState.maybeMap<ControlsView>(
      success: (_) => const ControlsView(
        isGeneratedButtonEnabled: true,
        isGenerating: false,
        isDownloadAvailable: true,
        isDownloadButtonVisible: true,
      ),
      loading: (_) => const ControlsView(
        isGeneratedButtonEnabled: false,
        isGenerating: true,
        isDownloadAvailable: false,
        isDownloadButtonVisible: true,
      ),
      orElse: () => const ControlsView(
        isGeneratedButtonEnabled: true,
        isGenerating: false,
        isDownloadAvailable: false,
        isDownloadButtonVisible: false,
      ),
    );
  },
);