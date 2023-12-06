import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({required this.firebaseAuth});

  bool isSignedIn() {
    return firebaseAuth.currentUser != null;
  }

  Future<UserId> signIn() async {
    final credentials = await firebaseAuth.signInAnonymously();
    return credentials.user!.uid;
  }

  UserId? getUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserId> signInWith(AuthProvider authProvider) async {
    switch (authProvider) {
      case AuthProvider.google:
        return signInWithGoogle();
      case AuthProvider.apple:
        return signInWithApple();
      case AuthProvider.anonymous:
        return signIn();
    }
  }

  Future<UserId> signInWithGoogle() async {
    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();
      final userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      return userCredential.user!.uid;
    }

    final googleCredential = await _getGoogleCredential();
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    return userCredential.user!.uid;
  }

  Future<UserId> signInWithApple() async {
    final appleProvider = AppleAuthProvider();

    late UserCredential userCredential;
    if (kIsWeb) {
      userCredential =
          await FirebaseAuth.instance.signInWithPopup(appleProvider);
    } else {
      userCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
    }

    return userCredential.user!.uid;
  }

  Future<void> linkWith(AuthProvider provider) async {
    try {
      switch (provider) {
        case AuthProvider.google:
          return await _linkWithGoogle();
        case AuthProvider.apple:
          return await _linkWithApple();
        case AuthProvider.anonymous:
          return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use' ||
          (e.message ?? '').contains('auth/credential-already-in-use')) {
        throw ProviderAlreadyInUse();
      }
      rethrow;
    }
  }

  Future<OAuthCredential> _getGoogleCredential() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser?.authentication;

    // Create a new credential
    return GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }

  Future<void> _linkWithGoogle() async {
    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();
      await firebaseAuth.currentUser!.linkWithPopup(googleProvider);
      return;
    }

    final googleCredential = await _getGoogleCredential();
    await firebaseAuth.currentUser!.linkWithCredential(googleCredential);
  }

  Future<void> _linkWithApple() async {
    final appleProvider = AppleAuthProvider();

    if (kIsWeb) {
      await firebaseAuth.currentUser!.linkWithPopup(appleProvider);
      return;
    }

    await firebaseAuth.currentUser!.linkWithProvider(appleProvider);
  }
}

class ProviderAlreadyInUse implements Exception {}
