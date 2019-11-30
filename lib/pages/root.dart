import 'package:flutter/material.dart';
import 'package:morpheus/morpheus.dart';
import 'package:impact/pages/home.dart';
import 'package:impact/pages/profile.dart';
import 'package:impact/pages/contacts.dart';
import 'package:impact/pages/connect.dart';
import 'package:impact/pages/chat.dart';
import 'package:impact/pages/messages.dart';

class RootPage extends StatefulWidget
{
  RootPage ({Key key}) : super(key: key);

  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
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
    HomePage(), //widget function call
    MessagesPage(),
    Recommendations(),
    MentorList(), // widget function call
    PersonalProfile(),
    
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
        title: Center(child: const Text('ImPACt')),
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
              icon: Icon(Icons.message),
              title: Text('Messaging'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inclusive),
              title: Text('Connect'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('Contacts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Personal Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.green[600],
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
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