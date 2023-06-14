import 'package:ankigpt/src/models/auth_provider.dart';
import 'package:ankigpt/src/models/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> signInWithGoogle() async {}

  Future<void> signInWithApple() async {}

  Future<void> linkWith(AuthProvider provider) async {}
}
