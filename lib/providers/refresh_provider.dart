import 'package:flutter/material.dart';

class Refresh with ChangeNotifier {
  int _hasInternet = 0;
  int get hasInternet => _hasInternet;
  void increment() {}

  void connected() {}
}
