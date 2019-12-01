import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/user.dart';

class Request {
  User mentee;
  User mentor;
  Timestamp timestamp;
  int status;
  DocumentReference reference;

  Request({
    this.mentee,
    this.mentor,
    this.status = 0,
  }) {
    this.timestamp = Timestamp.now();
    this.reference = null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "mentee": {
        "id": mentee.id,
        "firstName": mentee.firstName,
        "lastName": mentee.lastName,
        "email": mentee.email,
        "institution": mentee.institution,
        "college": mentee.college,
        "department": mentee.department,
        "description": mentee.description,
        "avatarURL": mentee.avatarURL
      }.cast<String, dynamic>(),
      "mentor": {
        "id": mentor.id,
        "firstName": mentor.firstName,
        "lastName": mentor.lastName,
        "email": mentor.email,
        "institution": mentor.institution,
        "college": mentor.college,
        "department": mentor.department,
        "description": mentor.description,
        "avatarURL": mentor.avatarURL
      }.cast<String, dynamic>(),
      "timestamp": this.timestamp,
      "status": this.status
    };

    return map;
  }

  Request.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['mentee'] != null),
      assert(map['mentor'] != null),
      assert(map['timestamp'] != null),
      assert(map['status'] != null),
      this.timestamp = map['timestamp'],
      this.status = map['status'] {
        Map<String, dynamic> menteeMap = map['mentee'].cast<String, dynamic>();
        Map<String, dynamic> mentorMap = map['mentor'].cast<String, dynamic>();

        mentee = User(id: menteeMap['id'],
                      firstName: menteeMap['firstName'],
                      lastName: menteeMap['lastName'],
                      email: menteeMap['email'],
                      institution: menteeMap['institution'],
                      college: menteeMap['college'],
                      department: menteeMap['department'],
                      description: menteeMap['description'],
                      avatarURL: menteeMap['avatarURL']);
        mentor = User(id: mentorMap['id'],
                      firstName: mentorMap['firstName'],
                      lastName: mentorMap['lastName'],
                      email: mentorMap['email'],
                      institution: mentorMap['institution'],
                      college: mentorMap['college'],
                      department: mentorMap['department'],
                      description: mentorMap['description'],
                      avatarURL: mentorMap['avatarURL']);
      }

  Request.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Request<$mentee.id:$mentor.id:$timestamp>";
}