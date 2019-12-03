import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:intl/intl.dart';
import 'package:impact/models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(106, 94, 175, 1.0),
      title: Center(
        child: Text("User Post Feed"),
      ),
    );
    return Scaffold(
      appBar: topAppBar,
      body: _buildBody(context), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: Text("Create A Post", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                  ),
                ),
                content: Container(
                  height: 120.0,
                  width: 100.0,
                  child: ListView(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: "Write: "), 
                        style: TextStyle(color: Colors.black)
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit", style: TextStyle(color: Colors.black))
                  )
                ],
              );
            },
          );
        }
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('post').orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 10.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final post = Post.fromSnapshot(data);
  final format = DateFormat("MMMd");
  return Padding(
      key: ValueKey(post.user),
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
              leading: Icon(Icons.account_circle),
              title: Text(post.user, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              trailing: Text(format.format(DateTime.fromMillisecondsSinceEpoch(post.date.seconds * 1000))),
            ),
            Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 14.0),
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