import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid == null ? "User not found" : null;
    } catch (exception) {
      return exception.toString();
    }
  }

  static Future<String> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // return user.uid;
      return user.uid == null ? "Error occurred" : null;
    } catch (exception) {
      return exception.toString();
    }
  }

  static Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  static Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  static Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  static Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
