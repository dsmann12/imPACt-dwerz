import 'package:flutter/material.dart';

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
  return Scaffold(
    body: Center(
      child: Card(
        child: Image.asset(
          'assets/rubber_duck.jpg',
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    ),
  );
}

Widget buildCoverImage(Size screenSize)
{
  return Container(
    height: screenSize.height / 2.6,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/rubber_duck.jpg'),
      fit: BoxFit.cover,
      ),
    ),
  );
}


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


//Main page widget state (displays the content of each tab)
class _MyStatefulWidgetState extends State<MyStatefulWidget>
{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    displayHomeContent(), //widget function call
    displayMentorList(), // widget function call
    Text(
      'Your Personal Profile',
      style: optionStyle,
    ),
    Text(
      'Search for Other Potential Mentors here',
      style: optionStyle,
    )
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
            title: Text('Contacts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
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
