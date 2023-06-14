import 'package:firebase_auth/firebase_auth.dart';

enum AuthProvider {
  google,
  anonymous,
  apple;

  String toUiString() {
    switch (this) {
      case AuthProvider.google:
        return 'Google';
      case AuthProvider.anonymous:
        return 'Anonymous';
      case AuthProvider.apple:
        return 'Apple';
    }
  }

  static AuthProvider fromFirebaseAuthUser(User user) {
    if (user.isAnonymous) {
      return AuthProvider.anonymous;
    }

    if (user.providerData.any((e) => e.providerId == 'google.com')) {
      return AuthProvider.google;
    }

    if (user.providerData.any((e) => e.providerId == 'apple.com')) {
      return AuthProvider.apple;
    }

    throw Exception('Unknown provider');
  }
}
