import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String major;
  String institution;
  String college;
  String department;
  List<String> interests;
  int role;
  String avatarURL;
  String description;
  List<String> mentors;
  List<String> mentees;
  DocumentReference reference;

  User({
    this.id = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.major = "",
    this.institution = "",
    this.college = "",
    this.department = "",
    this.role = 0,
    this.avatarURL = "",
    this.description = "",
  }) {
    this.interests = new List<String>();
    this.mentors = new List<String>();
    this.mentees = new List<String>();
    this.reference = null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "email": this.email,
      "major": this.major,
      "institution": this.institution,
      "college": this.college,
      "department": this.department,
      "interests": this.interests,
      "role": this.role,
      "avatarURL": this.avatarURL,
      "description": this.description,
      "mentors": this.mentors,
      "mentees": this.mentees,
    };

    return map;
  }

  User.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['id'] != null),
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
      id = map['id'],
      firstName = map['firstName'],
      lastName = map['lastName'],
      email = map['email'],
      major = map['major'],
      institution = map['institution'],
      college = map['college'],
      department = map['department'],
      interests = List.from(map['interests']),
      role = map['role'],
      avatarURL = map['avatarURL'],
      description = map['description'],
      mentors = List.from(map['mentors']),
      mentees = List.from(map['mentees']);

  User.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "User<$id:$firstName:$lastName>";
}