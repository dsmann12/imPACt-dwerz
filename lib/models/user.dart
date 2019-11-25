import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String major;
  final String institution;
  final String college;
  final String department;
  final List<String> interests;
  final Uint8 role;
  final String avatarURL;
  final String description;
  final List<String> mentors;
  final List<String> mentees;
  final DocumentReference reference;

  User.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['userId'] != null),
      assert(map['firstName'] != null),
      assert(map['lastName'] != null),
      assert(map['email'] != null),
      assert(map['major'] != null),
      assert(map['institution'] != null),
      assert(map['college'] != null),
      assert(map['department'] != null),
      assert(map['interests'] != null),
      assert(map['role'] != null),
      assert(map['avatarURL'] != null),
      assert(map['description'] != null),
      assert(map['mentors'] != null),
      assert(map['mentees'] != null),
      userId = map['userId'],
      firstName = map['firstName'],
      lastName = map['lastName'],
      email = map['email'],
      major = map['major'],
      institution = map['institution'],
      college = map['college'],
      department = map['department'],
      interests = map['interests'],
      role = map['role'],
      avatarURL = map['avatarURL'],
      description = map['description'],
      mentors = map['mentors'],
      mentees = map['mentees'];

  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "User<$userId:$firstName:$lastName>";
}