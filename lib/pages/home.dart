import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:impact/services/post_service.dart'; 
import 'package:intl/intl.dart';
import 'package:impact/models/post.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {

  final TextEditingController textEditingController = TextEditingController();

  User user = AuthService.getCurrentUser();
  // widget establishing the "create a post button" behind mentor status
  Widget onlyMentorCanPost() {
    if (user.isMentor()) {
      return FloatingActionButton(
          child: Icon(Icons.add_circle_outline),
          // outlining the parameters for the popup text box to create a post
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: Text("Create A Post", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                  ),
                  content: Container(
                    height: 120.0,
                    width: 100.0,
                    child: ListView(
                      children: <Widget>[
                        TextField(
                            controller: textEditingController,
                            minLines: null,
                            maxLines: null,
                            decoration: InputDecoration(labelText: "Write: "),
                            style: TextStyle(color: Colors.black)
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () async {
                          onPost(textEditingController.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                            "Submit", style: TextStyle(color: Colors.black))
                    )
                  ],
                );
              },
            );
          }
      );
    // create a post button does not show if not a mentor
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    // parameters for the Mentor Post Feed bar at the top
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.deepPurple,
      title: Center(
        child: Text("Mentor Post Feed"),
      ),
    );
    return Scaffold(
      appBar: topAppBar,
      body: _buildBody(context),
      floatingActionButton: onlyMentorCanPost(),
    );
  }

  // pulling the user info from the database
  Future<void> onPost(String text) async {
    if (text.trim() != "") {
      Post post = Post(
        userId: user.id,
        avatarURL: user.avatarURL,
        body: text,
        firstName: user.firstName,
        lastName: user.lastName,
        institution: user.institution,
        department: user.department,
        user: "${user.firstName} ${user.lastName}",
        mentees: user.mentees);
      
      PostService.addPost(post);
      textEditingController.clear();
    }
  }
  // populating feed with posts by users who have you as a mentee
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('post')
        .where("mentees", arrayContains: user.id)
        .orderBy('date', descending: true)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }
  // builds the feed by mapping the database information to the specified display parameters
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
  // widget specifying the build of cards that make up the feed
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final post = Post.fromSnapshot(data);
    
    if (post.userId == user.id) {
      return SizedBox.shrink();
    }

    final format = DateFormat("MMMd");
    return Padding(
        key: ValueKey(post.reference.documentID),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  leading: (post.avatarURL != "") ? CircleAvatar(backgroundImage: NetworkImage(post.avatarURL)) :(Icons.account_circle),
                  title: Text("${post.firstName} ${post.lastName}", style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
                  trailing: Text(format.format(
                      DateTime.fromMillisecondsSinceEpoch(
                          post.date.seconds * 1000))),
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 14.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(post.body, style: TextStyle(fontSize: 18)),
                    )
                )
              ],
            )
        )
    );
  }
}