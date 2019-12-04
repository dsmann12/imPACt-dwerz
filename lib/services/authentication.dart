import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User currentUser;
  static bool newSignUp = false;

  static Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print("User ID: ${user.uid}");
      if (user.uid == null) {
        return "Error occurred";
       } else { 
         currentUser = await UserService.getUser(user.uid);
         newSignUp = false;
         return null;
       }
    } catch (exception) {
      print(exception.toString());
      return exception.toString();
    }
  }

  static Future<String> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // return user.uid;
      print("User ID: ${user.uid}");
      if (user.uid == null) {
        return "Error occurred";
       } else { 
         currentUser = User(id: user.uid, email: email, role: 0);
         currentUser = await UserService.addUser(currentUser);
         newSignUp = true;
         return null;
       }
    } catch (exception) {
      return exception.toString();
    }
  }

  static User getCurrentUser() {
    return currentUser;
  }

  static Future<FirebaseUser> getFirebaseUser() async {
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
