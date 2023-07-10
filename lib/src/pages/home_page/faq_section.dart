import 'package:ankigpt/src/pages/widgets/animated_swap.dart';
import 'package:ankigpt/src/pages/widgets/max_width_constrained_box.dart';
import 'package:ankigpt/src/pages/widgets/section_title.dart';
import 'package:ankigpt/src/pages/widgets/theme.dart';
import 'package:ankigpt/src/providers/home_page_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle _getAnswerTextStyle(BuildContext context) =>
    DefaultTextStyle.of(context).style.copyWith(
          fontSize: 16,
          color: Colors.grey[700],
        );

class FaqSection extends ConsumerWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaxWidthConstrainedBox(
      key: ref.read(homePageScollViewProvider).faqSectionKey,
      maxWidth: 850,
      child: const Column(
        children: [
          SectionTitle(title: 'FAQ'),
          SizedBox(height: 48),
          _IsAnkiGptOpenSource(),
          _WhichLanguagesAreSupported(),
          _WhichModelIsUsed(),
          _AreMyDataUsedForTraining(),
          _DoesItWorkWithOtherApps(),
          _CurrentLimits(),
          _CouldHaveFalseInformation(),
        ],
      ),
    );
  }
}

class _IsAnkiGptOpenSource extends StatelessWidget {
  const _IsAnkiGptOpenSource();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Is the source code of AnkiGPT public?'),
      answer: _MarkdownAnswer(
        text:
            "Yes, the source code of the client for AnkiGPT is public and can be accessed by anyone interested. You can explore or even contribute to the project by visiting the GitHub repostiory ([nilsreichardt/ankigpt](https://github.com/nilsreichardt/ankigpt)). However, it's important to note that while the client's code is open, the backend (including the prompts) is closed source. We greatly value community input and appreciate all contributions to improve AnkiGPT.",
      ),
    );
  }
}

class _WhichLanguagesAreSupported extends StatelessWidget {
  const _WhichLanguagesAreSupported();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Which languages are supported?'),
      answer: Text(
          'AnkiGPT is designed to be a globally accessible tool, and as such, it supports nearly all languages. This broad language coverage allows users from various linguistic backgrounds to utilize AnkiGPT effectively. However, the level of support might vary depending on the language due to complexities in language structures and available datasets. We are consistently working on improving our support for all languages to ensure the best user experience possible.'),
    );
  }
}

class _WhichModelIsUsed extends StatelessWidget {
  const _WhichModelIsUsed();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Which model is used for AnkiGPT?'),
      answer: Text(
        "AnkiGPT uses as underlaying AI model GPT-3.5 by OpenAI. Support for GPT-4 is planned.",
      ),
    );
  }
}

class _AreMyDataUsedForTraining extends StatelessWidget {
  const _AreMyDataUsedForTraining();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text(
          'Is the content from my submitted lecture slides used for AI training?'),
      answer: _MarkdownAnswer(
        text:
            "No, your submitted content is not used for AI training. AnkiGPT leverages GPT models from OpenAI, which have a strong commitment to user privacy. OpenAI do not use customer-submitted data via their API to train or improve their models (Source: [API data usage policies](https://openai.com/policies/api-data-usage-policies)). Your lecture slides content is only processed to create flashcards and is not used for any other purposes, ensuring your information remains private and secure.",
      ),
    );
  }
}

class _DoesItWorkWithOtherApps extends StatelessWidget {
  const _DoesItWorkWithOtherApps();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Does AnkiGPT work with other flashcard apps than Anki?'),
      answer: Text(
        "As of now, AnkiGPT is designed specifically to work with the Anki flashcard app and we currently have no plans to extend support to other flashcard applications. This is to ensure the highest level of integration and functionality with Anki, thus providing an optimal user experience. We encourage users to utilize AnkiGPT with the Anki app for the best performance and reliability.",
      ),
    );
  }
}

class _CurrentLimits extends StatelessWidget {
  const _CurrentLimits();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('What are the current limitations?'),
      answer: _MarkdownAnswer(
        text:
            """While AnkiGPT is a powerful tool, it does have a few limitations to keep in mind:

* Firstly, remember that AI, including AnkiGPT, is not infallible. There will be occasional errors in the generated flashcards, as with any AI technology. Always review your flashcards for accuracy.

* Secondly, GPT models, at the current stage of development, aren't particularly adept at handling mathematical equations and formulas. This might impact the quality of flashcards in these areas.

* Lastly, for AnkiGPT Plus users who utilize the PDF input feature, please note that it currently only processes text. Any images, including diagrams and pictures in the PDF, will be ignored.

We're continually working on refining and expanding AnkiGPT's capabilities to improve your learning experience. Stay tuned for future updates and enhancements.""",
      ),
    );
  }
}

class _CouldHaveFalseInformation extends StatelessWidget {
  const _CouldHaveFalseInformation();

  @override
  Widget build(BuildContext context) {
    return const _FaqCard(
      question: Text('Could the flaschards contain false information?'),
      answer: Text(
          "Yes, it's possible that the flashcards generated by AnkiGPT may contain inaccuracies. Even with its advanced technology, AI is not perfect and can occasionally produce errors. Therefore, AnkiGPT should be used as an assistant to your study process, not a replacement for creating your own flashcards. We recommend that users always review and cross-verify the information on the flashcards to ensure accuracy. We're continually working to improve the reliability and precision of our tool, but human oversight remains an important part of the process to guarantee quality learning outcomes."),
    );
  }
}

/// A card that displays a question and optionally the answer, when the user
/// expands the card.
class _FaqCard extends StatefulWidget {
  const _FaqCard({
    required this.question,
    required this.answer,
  });

  final Widget question;
  final Widget answer;

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          key: ValueKey(widget.question),
          onTap: () {
            setState(() => isExpanded = !isExpanded);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutQuart,
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: DefaultTextStyle(
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 18,
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(child: widget.question),
                            const SizedBox(width: 8),
                            AnimatedSwap(
                              duration: const Duration(milliseconds: 275),
                              child: isExpanded
                                  ? const _HideAnswerIcon()
                                  : const _ShowAnswerIcon(),
                            ),
                          ],
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: isExpanded
                              ? Column(
                                  children: [
                                    const SizedBox(height: 18),
                                    DefaultTextStyle(
                                      style: _getAnswerTextStyle(context),
                                      child: widget.answer,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShowAnswerIcon extends StatelessWidget {
  const _ShowAnswerIcon();

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      key: ValueKey('ShowAnswer'),
      message: 'Show answer',
      child: Icon(
        Icons.keyboard_arrow_down,
      ),
    );
  }
}

class _HideAnswerIcon extends StatelessWidget {
  const _HideAnswerIcon();

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      key: ValueKey('HideAnswer'),
      message: 'Hide answer',
      child: Icon(
        Icons.keyboard_arrow_up,
      ),
    );
  }
}

class _MarkdownAnswer extends StatelessWidget {
  const _MarkdownAnswer({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: text,
      onTapLink: (_, href, __) {
        if (href == null) return;
        launchUrl(Uri.parse(href));
      },
      styleSheet: MarkdownStyleSheet(
        a: _getAnswerTextStyle(context).copyWith(
          decoration: TextDecoration.underline,
        ),
        p: _getAnswerTextStyle(context),
      ),
    );
  }
}
