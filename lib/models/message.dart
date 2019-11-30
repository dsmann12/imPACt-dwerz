import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase

class Chat {
  List<String> ids;
  Map<String, dynamic> users;
  List<Message> messages;
  DocumentReference reference;
  CollectionReference messagesReference;

  Chat() {
    this.ids = new List<String>();
    this.messages = new List<Message>();
    this.users = new Map<String, dynamic>();
    this.reference = null;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "ids": this.ids,
      "users": this.users
    };

    return map;
  }

  Chat.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['ids'] != null),
      assert(map['users'] != null),
      this.ids = List.from(map['ids']),
      this.users = map['users'].cast<String, dynamic>();

  Chat.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Message {
  String senderId;
  String senderFirstName;
  String senderLastName;
  String body;
  Timestamp timestamp;
  DocumentReference reference;
  DocumentReference chatReference;

  Message(DocumentReference chatReference, {
    this.senderId = "",
    this.senderFirstName = "",
    this.senderLastName = "",
    this.body = ""
  }) {
    this.timestamp = Timestamp.now();
    this.chatReference = chatReference;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "senderId": this.senderId,
      "senderFirstName": this.senderFirstName,
      "senderLastName": this.senderLastName,
      "body": this.body,
      "timestamp": this.timestamp,
      "chatReference": this.chatReference
    };

    return map;
  }

  Message.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['senderId'] != null),
      assert(map['senderFirstName'] != null),
      assert(map['senderLastName'] != null),
      assert(map['body'] != null),
      assert(map['timestamp'] != null),
      assert(map['chatReference'] != null),
      senderId = map['senderId'],
      senderFirstName = map['senderFirstName'],
      senderLastName = map['senderLastName'],
      body = map['body'],
      timestamp = map['timestamp'],
      chatReference = map['chatReference'];
    

  Message.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}