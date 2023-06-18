import 'package:ankigpt/src/models/controls_view.dart';
import 'package:ankigpt/src/models/generate_state.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:ankigpt/src/providers/is_editing_card_loading.dart';
import 'package:ankigpt/src/providers/is_search_loading_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'controls_view_provider.g.dart';

@Riverpod(keepAlive: true)
ControlsView controlsView(ControlsViewRef ref) {
  final generateState = ref.watch(generateNotifierProvider);
  final isSearching = ref.watch(isSearchLoadingProvider);
  final isEditing = ref.watch(isEditingCardLoadingProvider);
  return generateState.maybeMap<ControlsView>(
    success: (_) => ControlsView(
      isGeneratedButtonEnabled: true,
      isGenerating: false,
      isDownloadAvailable: true,
      isDownloadButtonVisible: true,
      showLoadingIndicator: isSearching || isEditing,
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
