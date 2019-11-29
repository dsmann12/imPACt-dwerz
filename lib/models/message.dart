import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class Conversation {
  List<String> ids;
  List<Message> messages;
  DocumentReference reference;

  Conversation.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['ids'] != null),
      assert(map['messages'] != null),
      ids = List.from(map['ids']) {
        List<Map<String, dynamic>> messagesMap = List.from(map['messages']);
        this.messages = messagesMap.map((message) => Message.fromMap(message)).toList();
      }

  Conversation.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Message {
  String senderId;
  String senderFirstName;
  String senderLastName;
  String body;
  Timestamp datetime;
  DocumentReference reference;

  Message.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['senderId'] != null),
      assert(map['senderFirstName'] != null),
      assert(map['senderLastName'] != null),
      assert(map['body'] != null),
      assert(map['datetime'] != null),
      senderId = map['senderId'],
      senderFirstName = map['senderFirstName'],
      senderLastName = map['senderLastName'],
      body = map['body'],
      datetime = map['datetime'];
    

  Message.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}

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