import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';


// A service to assist in authenticating a user
// Authentication is handled by firebase
// Methods are wrappers around a firebase authentication library
class AuthService {
  // FirebaseAuth object that contains methods to authenticate with firebase
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // currentUser stores the authenticated user as a User object
  static User currentUser;
  // boolean to determine if user is signing up with a new account
  static bool newSignUp = false;

  // method for signing into firebase
  // return null on success so FlutterLogin page will correctly load
  // return error string on error
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

  // method for signing up a new account into firebase
  // return null on success so FlutterLogin page will correctly load
  // error string on error
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

  // return a reference to the current user
  static User getCurrentUser() {
    return currentUser;
  }

  // return current user as Firebase Use robject
  static Future<FirebaseUser> getFirebaseUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // method to sign out of firebase
  static Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
