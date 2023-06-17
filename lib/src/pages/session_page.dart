import 'package:ankigpt/main.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/generate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionPage extends ConsumerStatefulWidget {
  const SessionPage({
    super.key,
    required this.sessionId,
  });

  final SessionId sessionId;

  @override
  ConsumerState<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends ConsumerState<SessionPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(generateNotifierProvider.notifier)
          .watch(sessionId: widget.sessionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
