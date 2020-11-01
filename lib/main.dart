import 'package:flutter/material.dart';
import 'package:learn_app/welcome/welcome_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TODO: Add Register Page
      home: WelcomeUI(),
    );
  }
}


