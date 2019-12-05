import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/message.dart';
import 'dart:async';

// A service to assist in getting, updating, and creating chat messages between users
// All data is handled by firebase
class MessagingService {
  final Duration timeout = const Duration(seconds: 30);

  // get a chat from firebase by the reference in the chat object
  static Future<Chat> getChat(Chat chat) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      chat = Chat.fromSnapshot(await chat.reference.get());
      chat.messages = await getMessages(chat);
    });
    return chat;
  }
 
  // add a new chat based on the chat object
  static Future<Chat> addChat(Chat chat) async {
    Map map = chat.toMap();

    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      chat.reference = await Firestore.instance.collection('chat').add(map);
    });

    Chat newChat = Chat.fromSnapshot(await chat.reference.get());

    return newChat;
  }

  // add a new message to the chat
  static Future<Message> addMessage(Message message) async {
    Map map = message.toMap();

    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      message.reference = await Firestore.instance.collection('chat').document(message.chatReference.documentID).collection('message').add(map);
    });

    return Message.fromSnapshot(await message.reference.get());
  }

  // get messages from a chat by the chat reference
  static Future<List<Message>> getMessages(Chat chat) async {
    List<Message> messages;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await chat.reference.collection('message').orderBy('timestamp').getDocuments();
      messages = snapshot.documents.map((snapshot) => Message.fromSnapshot(snapshot)).toList();
    });

    return messages;
  }

  // get chats for a specific user by their user id
  static Future<List<Chat>> getChatsByUser(String id) async {
    List<Chat> chats;

    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
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

  // get the chat between two specific users from firebase
  static Future<Chat> getChatBetweenUsers(String id1, String id2) async {
    try {
      Chat chat;
      List<Chat> chats;

      await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
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