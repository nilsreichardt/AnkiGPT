import 'package:ankigpt/src/models/controls_view.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/is_search_loading_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controls_view_provider.g.dart';

@riverpod
ControlsView controlsView(ControlsViewRef ref) {
  final generateState = ref.watch(generateNotifierProvider);
  final isSearching = ref.watch(isSearchLoadingProvider);
  return generateState.maybeMap<ControlsView>(
    success: (_) => ControlsView(
      isGeneratedButtonEnabled: true,
      isGenerating: false,
      isDownloadAvailable: true,
      isDownloadButtonVisible: true,
      showLoadingIndicator: isSearching,
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
}
