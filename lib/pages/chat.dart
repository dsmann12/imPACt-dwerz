import 'package:flutter/material.dart';
import 'package:impact/pages/bubble.dart';
import 'package:impact/models/message.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/messaging_service.dart';

class ChatPage extends StatefulWidget {
  final User currentUser;
  final Chat chat;

  ChatPage(User currentUser, Chat chat, {Key key})
    : this.currentUser = currentUser,
      this.chat = chat,
      super(key: key) {
        chat.messages = chat.messages.reversed.toList();
      }

  @override
  _ChatPageState createState() => _ChatPageState(currentUser: this.currentUser, chat: this.chat);
}

class _ChatPageState extends State<ChatPage> {
  User currentUser;
  Chat chat;
  BubbleStyle styleMe;
  BubbleStyle styleSomebody;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  _ChatPageState({this.currentUser, this.chat});

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.amber[900],
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Colors.deepPurple,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    String id = chat.ids.where((val) => val != currentUser.id).toList()[0];
    var otherUser = chat.users[id];

    if (chat.messages.length != 0) {
      MessagingService.getChat(chat).then((value) {
        setState(() {
          chat = value;
          chat.messages = chat.messages.reversed.toList();
        });
      });
    }
    

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: new CircleAvatar(backgroundImage: NetworkImage(otherUser['avatarURL'])),
          title: Text("${otherUser["firstName"]} ${otherUser["lastName"]}", style: TextStyle(color: Colors.white))
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _buildList(chat),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter text here",
                      ),
                      minLines: null,
                      maxLines: null,
                    )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: (textEditingController.text.length == 0) ? null : () async => onSend(textEditingController.text),
                    )
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }

  ListView _buildList(Chat chat) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: chat.messages.map((message) => _buildListItem(message)).toList(),
      controller: scrollController,
      reverse: true,
    );
  }

  Widget _buildListItem(Message message) {
    return Bubble(
      style: (message.senderId == currentUser.id) ? styleMe : styleSomebody,
      child: Text(message.body, style: TextStyle(color: Colors.white))
    );
  }

  Future<void> onSend(String text) async {
    if (text.trim() != "") {
      textEditingController.clear();
    }

    Message message = Message(this.chat.reference, 
      senderId: currentUser.id,
      senderFirstName: currentUser.firstName,
      senderLastName: currentUser.lastName,
      body: text);

    if (chat.messages.length == 0) {
      chat = await MessagingService.addChat(chat);
    }
    message.chatReference = chat.reference;
    message = await MessagingService.addMessage(message);
    setState(() {
      chat.messages.add(message);
      this.chat = chat;
      scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }
}
