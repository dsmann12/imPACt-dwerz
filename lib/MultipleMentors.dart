import 'package:flutter/material.dart'; 

void main() {
  runApp(MultipleMentors()); 
}

class MultipleMentors extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "List of Connections"),
              ],
            ),
            title: Text('imPACt'),
          ),
          body: TabBarView(
            children: [
              //buttons
              buildButton(text: "Direct Message")
              buildButton(text: "Profile")
              buildButton(text: "Feed")
            ],
          ),
        ),
      ),
    );
  }
}
