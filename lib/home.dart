import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for DateFormat class
import 'package:morpheus/morpheus.dart';
import 'contacts.dart';
import 'profile.dart';
import 'connect.dart';



class Home extends StatefulWidget
{
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

Widget displayHomeContent()
{
  return MyHomePage();
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Posts')),
      body: _buildBody(context),
    );
  }

//  Widget _buildBody(BuildContext context) {
  //  // TODO: get actual snapshot from Cloud Firestore
  //  return _buildList(context, dummySnapshot);
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
  String toString() => "Post<$body:$date:$user";
}

class _HomeState extends State<Home>
{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
//  final List<Widget> _screens = [
//    Scaffold(backgroundColor: Colors.green),
//    Scaffold(backgroundColor: Colors.red),
//    Scaffold(backgroundColor: Colors.blue),
//  ];
  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    displayHomeContent(), //widget function call
    displayMentorList(), // widget function call
    PersonalProfile(),
    Recommendations()
//    SearchBar()
//    Text(
//      'Search for Mentors here',
//      style: optionStyle,
//    )
  ];
  //event on tapping on a tab
  void _onItemTapped(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
  }
//Main page widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImPACt Application'),
      ),
      body: MorpheusTabView(
        child: _widgetOptions[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Post Feed'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              title: Text('Contacts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Personal Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive),
              title: Text('Connect'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[600],
          unselectedItemColor: Colors.black,
          onTap: (index) {
            if(index != _currentIndex) {
              setState(() => _currentIndex = index);
              _onItemTapped(index);
            }
          }
        //onTap: _onItemTapped,
      ),
    );
  }
}