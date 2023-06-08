import 'package:ankigpt/src/models/controls_view.dart';
import 'package:ankigpt/src/models/generate_state.dart';
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
        showLoadingIndicator: false,
      ),
      loading: (_) => ControlsView(
        isGeneratedButtonEnabled: false,
        isGenerating: true,
        isDownloadAvailable: false,
        isDownloadButtonVisible: true,
        showLoadingIndicator: generateState is GenerationStateLoading &&
            generateState.alreadyGeneratedCards.isNotEmpty,
      ),
      orElse: () => const ControlsView(
        isGeneratedButtonEnabled: true,
        isGenerating: false,
        isDownloadAvailable: false,
        isDownloadButtonVisible: false,
        showLoadingIndicator: false,
      ),
    );
  },
);
