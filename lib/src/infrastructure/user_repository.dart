import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository({required this.firebaseAuth});

  bool isSignIn() {
    return firebaseAuth.currentUser != null;
  }

  Future<void> signIn() async {
    await firebaseAuth.signInAnonymously();
  }
}
