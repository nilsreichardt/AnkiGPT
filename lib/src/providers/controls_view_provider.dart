import 'package:ankigpt/src/models/controls_view.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final controlsViewProvider = Provider<ControlsView>(
  (ref) {
    final generateState = ref.watch(generateStateProvider);
    return generateState.maybeMap<ControlsView>(
      loading: (_) => const ControlsView(
        isGeneratedButtonEnabled: false,
        isGenerating: true,
      ),
      orElse: () => const ControlsView(
        isGeneratedButtonEnabled: true,
        isGenerating: false,
      ),
    );
  },
);
