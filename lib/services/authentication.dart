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

  // static Future<List<User>> createUsers() async {
  //   List<User> users = [
  //     User(
  //       email: "karki@csc.lsu.edu",
  //       firstName: "Bijaya",
  //       lastName: "Karki",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/bijaya.karki.jpg",
  //       role: 1,
  //       ),
  //     User(
  //       email: "gb@csc.lsu.edu",
  //       firstName: "Gerarld",
  //       lastName: "Baumgartner",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/gerald.baumgartner.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "busch@csc.lsu.edu",
  //       firstName: "Konstantin",
  //       lastName: "Busch",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/konstantin.busch.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "carver@csc.lsu.edu",
  //       firstName: "Doris",
  //       lastName: "Carver",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/doris.carver2.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "fchen@csc.lsu.edu",
  //       firstName: "Feng",
  //       lastName: "Chen",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/feng.chen.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "jianhua@csc.lsu.edu",
  //       firstName: "Jianhua",
  //       lastName: "Chen",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/jianhua.chen.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "kundu@csc.lsu.edu",
  //       firstName: "Sukhamay",
  //       lastName: "Kundu",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/sukhamay.kundu.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "lee@csc.lsu.edu",
  //       firstName: "Kisung",
  //       lastName: "Lee",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/kisung.lee.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "mahmoud@csc.lsu.edu",
  //       firstName: "Anas",
  //       lastName: "Mahmoud",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/anas.mahmoud.jpg",
  //       role: 1,
  //     ),     
  //     User(
  //       email: "supratik@csc.lsu.edu",
  //       firstName: "Supratik",
  //       lastName: "Mukhopadhyay",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/supratik.mukhopadhyay.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "sjpark@csc.lsu.edu",
  //       firstName: "Seung-Jong",
  //       lastName: "Park",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/seungjong.park.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "golden@csc.lsu.edu",
  //       firstName: "Golden",
  //       lastName: "Richard III",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/golden2.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "rahul@csc.lsu.edu",
  //       firstName: "Rahul",
  //       lastName: "Shah",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/rahul.shah.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "msun@csc.lsu.edu",
  //       firstName: "Mingxuan",
  //       lastName: "Sun",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/mingxuan.sun.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "trianta@csc.lsu.edu",
  //       firstName: "Evangelos",
  //       lastName: "Triantaphyllou",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/evangelos.triantaphyllou.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "chenwang@csc.lsu.edu",
  //       firstName: "Chen",
  //       lastName: "Wang",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/chen.wang.png",
  //       role: 1,
  //     ),
  //     User(
  //       email: "qywang@csc.lsu.edu",
  //       firstName: "Quinyang",
  //       lastName: "Wamg",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/qingyang.wang.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "jye@csc.lsu.edu",
  //       firstName: "Jinwei",
  //       lastName: "Ye",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/jinwei.ye.png",
  //       role: 1,
  //     ),
  //     User(
  //       email: "zhang@csc.lsu.edu",
  //       firstName: "Jian",
  //       lastName: "Zhang",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/jian.zhang.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "paymond@lsu.edu",
  //       firstName: "Patti",
  //       lastName: "Aymond",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/aymond.patti.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "brener@csc.lsu.edu",
  //       firstName: "Nathan",
  //       lastName: "Brener",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/nathan.brener.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "duncan@csc.lsu.edu",
  //       firstName: "William",
  //       lastName: "Duncan",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/william.duncan.jpg",
  //       role: 1,
  //     ),
  //     User(
  //       email: "sbrandt@cct.lsu.edu",
  //       firstName: "Steve",
  //       lastName: "Brandt",
  //       institution: "Louisiana State University",
  //       college: "College of Engineering",
  //       department: "Computer Science",
  //       description: "I am faculty in the Computer Science department at LSU",
  //       avatarURL: "https://www.lsu.edu/eng/cse/people/faculty/photos/steve.brandt.jpg",
  //       role: 1,
  //     ),
  //   ];

  //   for (int i = 0; i < users.length; ++i) {
  //     User user = users[i];
  //     AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: "12345678");
  //     FirebaseUser firebaseUser = result.user;
  //     user.id = firebaseUser.uid;
  //   }

  //   users = await UserService.addUsers(users);

  //   return users;
  // }

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
          // update current user
        //  currentUser.interests = [
        //     "Computer Science",
        //     "Electrical Engineering",
        //     "Computer Engineering"
        //  ];

        //  currentUser.institution = "Louisiana State University";

        //  currentUser.firstName = "David";
        //  currentUser.lastName = "Scheuermann";

        //  currentUser.major = "Computer Science";
        //  currentUser.college = "College of Engineering";

        //  currentUser.description = "This is my in-app made test description!";

        //  currentUser = await UserService.updateUser(currentUser);

        //  List<User> users = await createUsers();
        //  User var_user = currentUser;
         return null;
       }
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
      print("User ID: ${user.uid}");
      if (user.uid == null) {
        return "Error occurred";
       } else { 
         currentUser = User(id: user.uid, email: email, role: 0);
         currentUser = await UserService.addUser(currentUser);
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
