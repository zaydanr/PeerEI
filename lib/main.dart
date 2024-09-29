import 'package:flutter/material.dart';
import 'contacts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Therapy Chatbots',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsScreen(), // Load the contacts screen
    );
  }
}
