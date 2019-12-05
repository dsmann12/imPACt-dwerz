import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/user.dart';
import 'dart:async';
import 'package:impact/services/authentication.dart';

// A service to assist in getting, updating, and creating users
// All data is handled by firebase
class UserService {
  final Duration timeout = const Duration(seconds: 30);

  // add new users to firebase
  static Future<List<User>> addUsers(List<User> users) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      users.forEach((user) async {
        Map map = user.toMap();
        user.reference = await Firestore.instance.collection('user').add(map);
      });
    });

    return users;
  }

  // add a new user to firebase
  static Future<User> addUser(User user) async {
    Map map = user.toMap();
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      user.reference = await Firestore.instance.collection('user').add(map);
    });

    return User.fromSnapshot(await user.reference.get());
  }

  // get user from firebase
  static Future<User> getUser(String id) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('user').where("id", isEqualTo: id).getDocuments();
    List<DocumentSnapshot> documents = snapshot.documents;
    DocumentSnapshot document = documents[0];
    User user = User.fromSnapshot(document);
    return user;
  }

  // update user in firebase
  static Future<User> updateUser(User user) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      await user.reference.updateData(user.toMap());
    });
    
    return user;
  }

  // get all users by ids
  static Future<List<User>> getUsers(List<String> ids) async {
    List<User> users;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('user').where("id", arrayContains: ids).getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      users = documents.map((documentSnapshot) => User.fromSnapshot(documentSnapshot)).toList();
    });

    return users;
  }

  // get all users with the mentor role from the database
  static Future<List<User>> getMentors() async {
    List<User> mentors;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('user').where("role", isEqualTo: 1).getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      mentors = documents.map((documentSnapshot) => User.fromSnapshot(documentSnapshot)).toList();
    });

    User currentUser = AuthService.getCurrentUser();
    mentors = mentors.where((mentor) => !mentor.mentees.contains(currentUser.id) && mentor.id != currentUser.id).toList();
    return mentors;
  }

  // get all mentors for a specific user
  static Future<List<User>> getMentorsByUser(String id) async {
    List<User> mentors;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('user')
        .where("role", isEqualTo: 1)
        .where("mentees", arrayContains: id)
        .getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      mentors = documents.map((documentSnapshot) => User.fromSnapshot(documentSnapshot)).toList();
    });

    return mentors;
  }

  // get all mentees for a specific user
  static Future<List<User>> getMenteesByUser(String id) async {
    List<User> mentees;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('user')
        .where("mentors", arrayContains: id)
        .getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      mentees = documents.map((documentSnapshot) => User.fromSnapshot(documentSnapshot)).toList();
    });

    return mentees;
  }
}