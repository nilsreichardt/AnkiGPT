import 'package:animations/animations.dart';
import 'package:ankigpt/src/models/card_feedback.dart';
import 'package:ankigpt/src/models/card_id.dart';
import 'package:ankigpt/src/models/session_id.dart';
import 'package:ankigpt/src/providers/dislike_provider.dart';
import 'package:ankigpt/src/providers/like_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showCardLikeDialog(
  BuildContext context, {
  required CardId cardId,
  required SessionId sessionId,
}) async {
  return showModal<void>(
    context: context,
    builder: (context) => CardLikeDialog(
      cardId: cardId,
      sessionId: sessionId,
    ),
    routeSettings: const RouteSettings(name: '/card-like-dialog'),
  );
}

Future<void> showCardDislikeDialog(
  BuildContext context, {
  required CardId cardId,
  required SessionId sessionId,
}) async {
  return showModal<void>(
    context: context,
    builder: (context) => CardDislikeDialog(
      cardId: cardId,
      sessionId: sessionId,
    ),
    routeSettings: const RouteSettings(name: '/card-dislike-dialog'),
  );
}

class CardLikeDialog extends ConsumerWidget {
  const CardLikeDialog({
    super.key,
    required this.cardId,
    required this.sessionId,
  });

  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardFeedbackBaseDialog(
      icon: const Icon(Icons.thumb_up),
      iconColor: Theme.of(context).colorScheme.primary,
      onSubmit: (values) {
        ref.read(likeCardProvider(
          sessionId: sessionId,
          cardId: cardId,
          text: values.$2,
        ));
      },
      textfieldHint: 'What do you like about the card?',
    );
  }
}

class CardDislikeDialog extends ConsumerWidget {
  const CardDislikeDialog({
    super.key,
    required this.cardId,
    required this.sessionId,
  });

  final CardId cardId;
  final SessionId sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _CardFeedbackBaseDialog(
      icon: const Icon(Icons.thumb_down),
      iconColor: Colors.red,
      onSubmit: (values) {
        ref.read(dislikeCardProvider(
          sessionId: sessionId,
          cardId: cardId,
          checkboxes: values.$1,
          text: values.$2,
        ));
      },
      feedbackTypes: CardDislikeFeedbackType.values,
      textfieldHint:
          'What is the issue with the card? How could it be improved?',
    );
  }
}

class _CardFeedbackBaseDialog extends StatefulWidget {
  const _CardFeedbackBaseDialog({
    required this.iconColor,
    required this.icon,
    required this.onSubmit,
    required this.textfieldHint,
    this.feedbackTypes = const [],
  });

  final Color iconColor;
  final Widget icon;
  final List<CardFeedbackType> feedbackTypes;
  final ValueChanged<(Map<CardFeedbackType, bool>, FeedbackText?)> onSubmit;
  final String textfieldHint;

  @override
  State<_CardFeedbackBaseDialog> createState() =>
      _CardFeedbackBaseDialogState();
}

typedef FeedbackText = String;

class _CardFeedbackBaseDialogState extends State<_CardFeedbackBaseDialog> {
  Map<CardFeedbackType, bool> feedbackCheckboxes = {};
  String? feedbackText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Material(
            shape: const CircleBorder(),
            color: widget.iconColor.withOpacity(0.15),
            child: IconTheme(
              data:
                  Theme.of(context).iconTheme.copyWith(color: widget.iconColor),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: widget.icon,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text('Provide additional Feedback'),
          ),
          const CloseButton(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              "Feedback has been sent 🎉 Thank you! If you have additional feedback, please fill out the text field."),
          const SizedBox(height: 12),
          TextField(
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
              hintText: widget.textfieldHint,
              border: const OutlineInputBorder(),
            ),
            onChanged: (t) => feedbackText = t,
          ),
          const SizedBox(height: 12),
          for (final type in widget.feedbackTypes)
            CheckboxListTile.adaptive(
              contentPadding: const EdgeInsets.only(left: 2, right: 16),
              controlAffinity: ListTileControlAffinity.leading,
              value: feedbackCheckboxes[type] ?? false,
              title: Text(type.getCheckboxText()),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  feedbackCheckboxes[type] = v;
                });
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSubmit((feedbackCheckboxes, feedbackText));
            Navigator.of(context).pop();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
