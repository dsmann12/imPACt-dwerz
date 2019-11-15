import 'package:flutter/material.dart';

//MentorList: Added by Ward Leavines
import 'MentorList.dart';

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


//Main page widget state (displays the content of each tab)
class _MyStatefulWidgetState extends State<MyStatefulWidget>
{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Mentors',
      style: optionStyle,
    ),
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


  //MentorList: Ward Leavines 
  /*
  List<Widget> _getMatchCard(){
    List<MentorList> card = new List();
    cards.add(MentorList(255, 0, 0, 10));
    cards.add(MentorList(0, 255, 0, 20));
    cards.add(MentorList(0, 0, 255, 30));

    List<Widget> cardList = new List(); 
    for(int x = 0 ; x < 3 ; x++){

      cardList.add(
        Positioned(
          top: cards[x].margin, 
          child: Draggable(
            onDragComplete4d: (){
               
            }, 
            childWhenDragging: Container(),
            feedback: Card(
              elevation 12, 
              color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor),
              shape: 
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded rectangle Border
              child: Container(
                width: 240,
                height: 300, 
                ), //Container
              ), // Card
              child: Card(
                elevation: 12, 
                color: Color.fromARGB(255, cards[x].redColor, cards[x].greenColor, cards[x].blueColor),
                shape: 
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), // Rounded Rectangle Borer
                child: Container(
                  width: 240, 
                  height: 300, 
                ), // Container
                ), // Card
              ), // Draggable
            )); // Positioned

            return cardList;
     }
  }
  */
  //MentorList: Ward Leavines



}
