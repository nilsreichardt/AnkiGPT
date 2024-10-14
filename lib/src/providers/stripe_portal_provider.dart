import 'package:ankigpt/src/providers/get_stripe_portal_url_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'stripe_portal_provider.g.dart';

@Riverpod(keepAlive: true)
class StripePortal extends _$StripePortal {
  @override
  String? build() {
    return null;
  }

  Future<String> generateUrl() async {
    final url = await ref.read(getStripePortalUrlProvider.future);
    state = url;
    return url;
  }

  void reset() {
    state = null;
  }

  Future<void> open() async {
    final url = state ?? await generateUrl();
    reset();
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: '_self',
    );
  }
}
