import 'package:ankigpt/src/pages/widgets/ankigpt_card.dart';
import 'package:ankigpt/src/providers/shared_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewCard extends ConsumerStatefulWidget {
  const NewCard({super.key});

  @override
  ConsumerState<NewCard> createState() => _NewCardState();
}

class _NewCardState extends ConsumerState<NewCard> {
  static const _key = 'shown-card-gpt';
  bool? shouldShow;

  @override
  void initState() {
    super.initState();
  }

  void shouldShowCard(SharedPreferences? sharedPreferences) {
    if (shouldShow != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (sharedPreferences != null) {
        setState(() {
          shouldShow = !sharedPreferences.containsKey(_key);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = ref.watch(sharedPreferencesAccesserProvider);
    shouldShowCard(sharedPreferences);

    const url = 'https://chatg.pt/ankigpt';
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: (shouldShow ?? false)
          ? Padding(
              padding: const EdgeInsets.only(top: 24),
              child: AnkiGptCard(
                onPressed: () async {
                  launchUrlString(url);
                },
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: Colors.orange.withOpacity(0.2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'New: AnkiGPT as GPT (requires ChatGPT Plus): $url',
                      style: TextStyle(
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    CloseButton(
                      color: Colors.deepOrange,
                      onPressed: () async {
                        if (sharedPreferences != null) {
                          await sharedPreferences.setBool(_key, true);
                        }

                        setState(() {
                          shouldShow = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
