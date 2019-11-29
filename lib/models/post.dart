import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class Post {
  String body;
  Timestamp date;
  String user;
  String userId;
  String firstName;
  String lastName;
  String institution;
  String department;
  String avatarURL;
  int type;
  DocumentReference reference;

  Post({
    this.user = "",
    this.body = "",
    this.userId = "",
    this.firstName = "",
    this.lastName = "",
    this.institution = "",
    this.department = "",
    this.avatarURL = "",
    this.type = 0
  }) {
    this.date = Timestamp.now();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "user": this.user,
      "body": this.body,
      "date": this.date,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "institution": this.institution,
      "department": this.department,
      "avatarURL": this.avatarURL,
      "type": this.type
    };

    return map;
  }

  Post.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['body'] != null),
      assert(map['date'] != null),
      assert(map['user'] != null),
      assert(map['userId'] != null),
      assert(map['firstName'] != null),
      assert(map['lastName'] != null),
      assert(map['institution'] != null),
      assert(map['department'] != null),
      assert(map['avatarURL'] != null),
      assert(map['type'] != null),
      body = map['body'],
      date = map['date'],
      user = map['user'],
      userId = map['userId'],
      firstName = map['firstName'],
      lastName = map['lastName'],
      institution = map['institution'],
      department = map['department'],
      avatarURL = map['avatarURL'],
      type = map['type'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Post<$body:$date:$user>";
}