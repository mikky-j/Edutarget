import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map((user) => user?.uid);
  User get user => _firebaseAuth.currentUser;

  Future<String> createUserWithEmailAndPassword(String email, String password,
      {String userName = "user"}) async {
    try {
      final UserCredential currentUser =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await currentUser.user.updateProfile(displayName: userName);
      await _firebaseAuth.currentUser.reload();
      return currentUser.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password is too weak");
      } else if (e.code == "email-already-in-use") {
        print("The email has been taken");
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      final currentUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return currentUser.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print("The password is wrong");
      } else if (e.code == "invalid-email") {
        print("The email is wrong");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
