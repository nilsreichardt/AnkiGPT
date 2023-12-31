import 'package:ankigpt/src/models/flavor.dart';
import 'package:ankigpt/src/models/session_dto.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/flavor_provider.dart';
import 'package:ankigpt/src/providers/session_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'share_controller_provider.g.dart';

@riverpod
class ShareController extends _$ShareController {
  Visibility? _initialVisibility;

  @override
  ShareState build(SessionId sessionId) {
    return ShareStateLoading(
      sessionId: sessionId,
    );
  }

  Future<void> load() async {
    final repository = ref.read(sessionRepositoryProvider);
    try {
      final session = await repository.getSession(sessionId);

      if (session == null) {
        state = ShareStateError(
          sessionId: sessionId,
          error: 'Could not find deck.',
        );
        return;
      }

      _initialVisibility = session.visibility;

      final isDeckGeneratedByCustomGpt = session.userId == 'gpts';
      if (isDeckGeneratedByCustomGpt) {
        state = ShareStateGpt(
          sessionId: sessionId,
          url: _getShareUrl(sessionId),
        );
        return;
      }

      state = ShareStateLoaded(
        sessionId: sessionId,
        visibility: session.visibility,
        url: switch (session.visibility) {
          Visibility.private => null,
          Visibility.anyoneWithLink => _getShareUrl(sessionId),
        },
      );
    } catch (e) {
      state = ShareStateError(
        sessionId: sessionId,
        error: e,
      );
    }
  }

  Future<void> setVisibility(Visibility visibility) async {
    if (visibility == _initialVisibility) {
      state = ShareStateLoaded(
        sessionId: sessionId,
        visibility: visibility,
        url: switch (visibility) {
          Visibility.private => null,
          Visibility.anyoneWithLink => _getShareUrl(sessionId),
        },
      );
    } else {
      state = ShareStateSelected(
        sessionId: sessionId,
        visibility: visibility,
      );
    }
  }

  Future<void> save() async {
    final visibility = switch (state) {
      ShareStateSelected(visibility: final visibility) => visibility,
      ShareStateError(visibility: final visibility) => visibility,
      _ => null,
    };

    if (visibility == null) {
      return;
    }

    final repository = ref.read(sessionRepositoryProvider);
    try {
      state = ShareStateUpdating(
        sessionId: sessionId,
        visibility: visibility,
      );
      await repository.setVisibility(sessionId, visibility);
      state = ShareStateLoaded(
        sessionId: sessionId,
        visibility: visibility,
        url: switch (visibility) {
          Visibility.private => null,
          Visibility.anyoneWithLink => _getShareUrl(sessionId),
        },
      );
      _initialVisibility = visibility;
    } catch (e) {
      state = ShareStateError(
        sessionId: sessionId,
        error: e,
        visibility: visibility,
      );
    }
  }

  Uri _getShareUrl(SessionId sessionId) {
    final flavor = ref.read(flavorProvider);

    final baseUrl =
        Uri.parse('https://${flavor == Flavor.dev ? 'dev.' : ''}ankigpt.help');
    return baseUrl.replace(
      path: '/deck/$sessionId',
    );
  }
}

sealed class ShareState {
  const ShareState({
    required SessionId sessionId,
  });
}

class ShareStateLoading extends ShareState {
  const ShareStateLoading({
    required super.sessionId,
  });
}

class ShareStateLoaded extends ShareState {
  const ShareStateLoaded({
    required super.sessionId,
    required this.visibility,
    required this.url,
  });

  final Visibility visibility;
  final Uri? url;
}

class ShareStateSelected extends ShareState {
  const ShareStateSelected({
    required super.sessionId,
    required this.visibility,
  });

  final Visibility visibility;
}

class ShareStateError extends ShareState {
  const ShareStateError({
    required super.sessionId,
    required this.error,
    this.visibility,
  });

  final Object error;
  final Visibility? visibility;
}

class ShareStateUpdating extends ShareState {
  const ShareStateUpdating({
    required super.sessionId,
    required this.visibility,
  });

  final Visibility visibility;
}

/// When the generated a deck with custom GPTs, these deck are always public.
class ShareStateGpt extends ShareState {
  const ShareStateGpt({
    required super.sessionId,
    required this.url,
  });

  final Visibility visibility = Visibility.anyoneWithLink;
  final Uri url;
}
