import 'package:flutter/material.dart';
import 'package:impact/pages/bubble.dart';
import 'package:impact/models/message.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/messaging_service.dart';

class ChatPage extends StatefulWidget {
  User currentUser;
  Chat chat;

  ChatPage(User currentUser, Chat chat, {Key key})
    : this.currentUser = currentUser,
      this.chat = chat,
      super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(currentUser: this.currentUser, chat: this.chat);
}

class _ChatPageState extends State<ChatPage> {
  User currentUser;
  Chat chat;
  BubbleStyle styleMe;
  BubbleStyle styleSomebody;

  final TextEditingController textEditingController = TextEditingController();

  _ChatPageState({this.currentUser, this.chat});

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.amber[800],
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      // color: Color.fromARGB(255, 225, 255, 199),
      color: Colors.deepPurple,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    String id = chat.ids.where((val) => val != currentUser.id).toList()[0];
    var otherUser = chat.users[id];

    MessagingService.getChat(chat).then((value) {
      setState(() {
        chat = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: new CircleAvatar(backgroundImage: NetworkImage(otherUser['avatarURL'])),
          title: Text("${otherUser["firstName"]} ${otherUser["lastName"]}", style: TextStyle(color: Colors.white))
        ),
      ),
      body: Container(
        color: Colors.white,
        // child: ListView.builder(
        //   itemBuilder: (BuildContext context, int position) {
        //     Message message = chat.messages[position];
        //     return Bubble(
        //       style: (message.senderId == currentUser.id) ? styleMe : styleSomebody,
        //       child: Text(message.body, style: TextStyle(color: Colors.white))
        //     );
        //   },
        //   padding: EdgeInsets.all(8.0),
        //   itemCount: chat.messages.length,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Expanded(
                child: _buildList(chat),
                // child: ListView(children: <Widget>[Text("This is a text"), Text("This is a second text")],)
              // child: new ListView.builder(
              //   itemBuilder: (BuildContext context, int position) {
              //     Message message = chat.messages[position];
              //     return Center(child: Text(message.body, style: TextStyle(color: Colors.white)));
              //     // return Bubble(
              //     //   style: (message.senderId == currentUser.id) ? styleMe : styleSomebody,
              //     //   child: Text(message.body, style: TextStyle(color: Colors.white))
              //     // );
              //   },
              //   padding: EdgeInsets.all(8.0),
              //   itemCount: chat.messages.length,
              // ),
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
                      // expands: true,
                    )
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => onSend(textEditingController.text),
                    )
                  )
                ],
              )
            )
            
        //     // Row(children: <Widget>[
        //     //   TextField(
        //     //     decoration: InputDecoration(
        //     //       border: InputBorder.none,
        //     //       hintText: "Enter text here"
        //     //     ),
        //     //   )
        //     // ],)
          ],
        )
        // child: ListView(
        //   padding: EdgeInsets.all(8.0),
        //   children: [
        //     Bubble(
        //       alignment: Alignment.center,
        //       // color: Color.fromARGB(255, 212, 234, 244),
        //       color: Colors.deepPurple,
        //       elevation: 1 * px,
        //       margin: BubbleEdges.only(top: 8.0),
        //       child: Text('TODAY', style: TextStyle(fontSize: 10, color: Colors.white)),
        //     ),
        //     Bubble(
        //       style: styleSomebody,
        //       child: Text('Hi Jason. Sorry to bother you. I have a queston for you.', style: TextStyle(color: Colors.white),),
        //     ),
        //     Bubble(
        //       style: styleMe,
        //       child: Text('Whats\'up?', style: TextStyle(color: Colors.white)),
        //     ),
        //     Bubble(
        //       style: styleSomebody,
        //       child: Text('I\'ve been having a problem with my computer.', style: TextStyle(color: Colors.white)),
        //     ),
        //     Bubble(
        //       style: styleSomebody,
        //       margin: BubbleEdges.only(top: 2.0),
        //       nip: BubbleNip.no,
        //       child: Text('Can you help me?', style: TextStyle(color: Colors.white)),
        //     ),
        //     Bubble(
        //       style: styleMe,
        //       child: Text('Ok', style: TextStyle(color: Colors.white)),
        //     ),
        //     Bubble(
        //       style: styleMe,
        //       nip: BubbleNip.no,
        //       margin: BubbleEdges.only(top: 2.0),
        //       child: Text('What\'s the problem?', style: TextStyle(color: Colors.white)),
        //     ),
          // ],
        ),
      // ),
    );
  }

  ListView _buildList(Chat chat) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      children: chat.messages.map((message) => _buildListItem(message)).toList(),
    );
  }

  Widget _buildListItem(Message message) {
    return Bubble(
      style: (message.senderId == currentUser.id) ? styleMe : styleSomebody,
      child: Text(message.body, style: TextStyle(color: Colors.white))
    );
  }

  void onSend(String text) {
    if (text.trim() != "") {
      textEditingController.clear();
    }

    Message message = Message(this.chat.reference, 
      senderId: currentUser.id,
      senderFirstName: currentUser.firstName,
      senderLastName: currentUser.lastName,
      body: text);

    chat.messages.add(message);
    MessagingService.addMessage(message);
    setState(() {
      chat = chat;
    });
  }
}
