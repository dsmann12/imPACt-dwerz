import 'package:flutter/material.dart';

class MatchingButton extends StatelessWidget {
  @override
  Widget build(BuildContet context) {
    return Scaffold(
      appBar: AppBar(
        title: text('imPACt'),
      ),
      body: Center(
        child: FlatButton.icon(
          color: Colors.green, 
          label: Text('Request Mentorship'), // Text in button displays
          onPressed: () {
            //Code to execute when Floating Action Button is clicked
          },
        ),
      ),
    );
  }
}