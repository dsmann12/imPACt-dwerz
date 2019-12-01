import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/message.dart';
import 'dart:async';

class MessagingService {

  static Future<Chat> getChat(Chat chat) async {
    await Firestore.instance.runTransaction((Transaction tx) async {
      chat = Chat.fromSnapshot(await chat.reference.get());
      chat.messages = await getMessages(chat);
    });
    return chat;
  }
 
  static Future<Chat> addChat(Chat chat) async {
    Map map = chat.toMap();

    await Firestore.instance.runTransaction((Transaction tx) async {
      chat.reference = await Firestore.instance.collection('chat').add(map);
      // await Firestore.instance.collection('chat').document(chat.reference.documentID).collection('message').document().setData({});
      // chat.messagesReference = Firestore.instance.collection('chat').document(chat.reference.documentID).collection('message');
    });

    Chat newChat = Chat.fromSnapshot(await chat.reference.get());

    return newChat;
  }

  static Future<Message> addMessage(Message message) async {
    Map map = message.toMap();

    await Firestore.instance.runTransaction((Transaction tx) async {
      message.reference = await Firestore.instance.collection('chat').document(message.chatReference.documentID).collection('message').add(map);
      // await Firestore.instance.collection('chat').document(chat.reference.documentID).collection('message').document().setData({});
    });

    return Message.fromSnapshot(await message.reference.get());
  }

  static Future<List<Message>> getMessages(Chat chat) async {
    List<Message> messages;
    await Firestore.instance.runTransaction((Transaction tx) async {
      QuerySnapshot snapshot = await chat.reference.collection('message').orderBy('timestamp').getDocuments();
      messages = snapshot.documents.map((snapshot) => Message.fromSnapshot(snapshot)).toList();
      // await Firestore.instance.collection('chat').document(chat.reference.documentID).collection('message').document().setData({});
    });

    return messages;
  }

  static Future<List<Chat>> getChatsByUser(String id) async {
    List<Chat> chats;

    await Firestore.instance.runTransaction((Transaction tx) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('chat').where("ids", arrayContains: id).getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;
      chats = documents.map((documentSnapshot) => Chat.fromSnapshot(documentSnapshot)).toList();
    });

    for (int i = 0; i < chats.length; ++i) {
      Chat chat = chats[i];
      chat.messages = await getMessages(chat);
    }

    return chats;
  }

  static Future<Chat> getChatBetweenUsers(String id1, String id2) async {
    try {
      Chat chat;
      List<Chat> chats;

      await Firestore.instance.runTransaction((Transaction tx) async {
        QuerySnapshot snapshot = await Firestore.instance.collection('chat')
            .where("ids", arrayContains: id1)
            .getDocuments();
        List<DocumentSnapshot> documents = snapshot.documents;
        chats = documents.map((documentSnapshot) => Chat.fromSnapshot(documentSnapshot)).toList();

        chats = chats.where((chat) => chat.ids.contains(id2)).toList();
        if (chats.length == 0) {
          return null;
        }
        chat = chats[0];
        chat.messages = await getMessages(chat);
      });

      return chat;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}