import 'package:flutter/material.dart';
import 'package:impact/models/chat_model.dart';
import 'package:impact/models/message.dart';
import 'package:impact/services/messaging_service.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/models/user.dart';
import 'package:impact/pages/chat.dart';

class MessagesPage extends StatefulWidget
{
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage>
{
  User user = AuthService.getCurrentUser();
  List<Chat> chats;

  @override
  Widget build(BuildContext context) {
    MessagingService.getChatsByUser(user.id).then((allChats) {
      setState(() {
        chats = allChats;
      });
    });

    return (chats == null) ? Center(child: CircularProgressIndicator()) : ListView.builder(
          itemBuilder: (BuildContext context, int position) {
            Chat chat = chats[position];
            String id = chat.ids.where((val) => val != user.id).toList()[0];
            var otherUser = chat.users[id];
            return new GestureDetector(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ChatPage(user, chat))),
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Card(
                    elevation: 1.0,
                    color: const Color(0xFFFFFFFF),
                    child: new ListTile(
                      leading: new CircleAvatar(
                        backgroundImage: new NetworkImage(otherUser['avatarURL']),
                      ),
                      title: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            // ChatMockData[position].name,
                            "${otherUser["firstName"]} ${otherUser["lastName"]} ",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            ChatMockData[position].time,
                            style: new TextStyle(
                                color: Colors.grey, fontSize: 14.0),
                          ),
                        ],
                      ),
                      subtitle: new Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: new Text(
                          // ChatMockData[position].message,
                          chats[position].messages[chats[position].messages.length - 1].body,
                          style: new TextStyle(
                              color: Colors.grey, fontSize: 15.0),
                        ),
                      ),
                    )))
            );
          },
          // itemCount: ChatMockData.length);
          itemCount: chats.length);
  }
}

