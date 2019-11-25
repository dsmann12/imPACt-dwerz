import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class Post {
  final String body;
  final Timestamp date;
  final String user;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['body'] != null),
      assert(map['date'] != null),
      assert(map['user'] != null),
      body = map['body'],
      date = map['date'],
      user = map['user'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Post<$body:$date:$user>";
}