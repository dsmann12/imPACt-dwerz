import 'package:flutter/material.dart';

Widget displayMentorList() {
  return Scaffold(
      body: Center(
          child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: Text('Anas Nash Mahmoud'),
                    subtitle: Text('Computer Science Professor at LSU'),
                  )
                ],
              )
          )
      )
  );
}