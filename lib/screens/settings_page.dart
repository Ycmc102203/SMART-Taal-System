import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text('Settings Screen',
            style: TextStyle(color: Colors.white, fontSize: 40)),
      ), // Center
    ); // Scaffold
  }
}
