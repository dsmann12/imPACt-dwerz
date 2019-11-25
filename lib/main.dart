import 'package:flutter/material.dart';
import 'package:impact/pages/root.dart';

// main entry point
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static const String _title = 'FLutter Demo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: RootPage(),
    );
  }
}


