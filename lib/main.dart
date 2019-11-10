import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';   // for DateFormat class


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const String _title = 'FLutter Demo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

//Main page widget instantiation
class MyStatefulWidget extends StatefulWidget
{
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

Widget displayHomeContent()
{
  return MyHomePage();
  // return Scaffold(
  //   body: Center(
  //     child: Card(
  //       child: Image.asset(
  //         'assets/rubber_duck.jpg',
  //         fit: BoxFit.cover,
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       elevation: 5,
  //       margin: EdgeInsets.all(10),
  //     ),
  //   ),
  // );
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
     appBar: AppBar(title: Text('Posts')),
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
  //  return Padding(
  //   //  key: ValueKey(record.name),
  //    key: ValueKey(post.user),
  //    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //    child: Container(
  //      decoration: BoxDecoration(
  //        border: Border.all(color: Colors.grey),
  //        borderRadius: BorderRadius.circular(5.0),
  //      ),
  //      child: ListTile(
  //       //  title: Text(record.name),
  //       //  trailing: Text(record.votes.toString()),
  //       //  onTap: () => print(record),
  //       title: Text(post.user),
  //       // trailing: Text(post.date.toString()),
  //       onTap: () => print(post)
  //      ),
  //    ),
  //  );
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

//Widget buildCoverImage(Size screenSize)
//{
//  return Container(
//    height: screenSize.height / 2.6,
//    decoration: BoxDecoration(
//      image: DecorationImage(image: AssetImage('assets/rubber_duck.jpg'),
//      fit: BoxFit.cover,
//      ),
//    ),
//  );
//}


Widget displayMentorList() {
  return Scaffold(
      body: Center(
          child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text('Nash Mahmoud'),
                    subtitle: Text('CSC 4330 Instructor'),
                  )
                ],
              )
          )
      )
  );
}
//State widget for the personal profile tab
class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => new _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 90.0),
                    Text(
                      'Tom Cruise',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Subscribe guys',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 25.0),
//                    Container(
//                        height: 30.0,
//                        width: 95.0,
//                        child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          shadowColor: Colors.greenAccent,
//                          color: Colors.green,
//                          elevation: 7.0,
//                          child: GestureDetector(
//                            onTap: () {},
//                            child: Center(
//                              child: Text(
//                                'Edit Name',
//                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
//                              ),
//                            ),
//                          ),
//                        )),
                    SizedBox(height: 25.0),
//                    Container(
//                        height: 30.0,
//                        width: 95.0,
//                        child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          shadowColor: Colors.redAccent,
//                          color: Colors.red,
//                          elevation: 7.0,
//                          child: GestureDetector(
//                            onTap: () {},
//                            child: Center(
//                              child: Text(
//                                'Log out',
//                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
//                              ),
//                            ),
//                          ),
//                        ))
                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for a mentor"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      //drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  final mentors = [
    "Nash Mahmoud",
    "Grant Williams",
    "Golden Richard",
    "Patti Aymond",
    "William Duncan",
    "Feng Chen",
  ];

  final recentMentors = [
    "Grant Williams",
    "Golden Richard",
    "Patti Aymond",
    "William Duncan",
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
        close(context, null);
      })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ),
    onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 400.0,
        width: 400.0,
        child: Card(
          color: Colors.purple,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?
        recentMentors
        : mentors.where((p) => p.startsWith(query)).toList();
    
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.person),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0, query.length),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.grey))
        ]),
      ),
      ),
      itemCount: suggestionList.length,
    );
  }
}




//Main page widget state (displays the content of each tab)
class _MyStatefulWidgetState extends State<MyStatefulWidget>
{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    displayHomeContent(), //widget function call
    displayMentorList(), // widget function call
    PersonalProfile(),
    SearchBar()
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            title: Text('List of Mentors'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Personal Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search for Mentors'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[600],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
