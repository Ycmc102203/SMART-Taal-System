import 'package:flutter/material.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text('Manual Screen',
            style: TextStyle(color: Colors.white, fontSize: 40)),
      ), // Center
    ); // Scaffold
  }
}
