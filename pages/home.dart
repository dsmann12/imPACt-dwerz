import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:intl/intl.dart'; // for DateFormat class
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
    return Scaffold(
      //appBar: AppBar(title: Text('Posts')),
      body: _buildBody(context),
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

//  Widget _buildList(BuildContext context, List<Map> snapshot) {
Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

//  Widget _buildListItem(BuildContext context, Map data) {
//    final record = Record.fromMap(data);
Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //  final record = Record.fromSnapshot(data);
  final post = Post.fromSnapshot(data);
  final format = DateFormat("MMMd");
  return Padding(
    //  key: ValueKey(record.name),
      key: ValueKey(post.user),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 1.0),
      child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(post.user),
                trailing: Text(format.format(DateTime.fromMillisecondsSinceEpoch(post.date.seconds * 1000))),
              ),
              Container(
                  padding: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(post.body),
                  )
              )
            ],
          )
      )
  );
}