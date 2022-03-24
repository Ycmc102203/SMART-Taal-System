import 'package:flutter/material.dart';

innerShadow() {
  return [
    const BoxShadow(
      color: Color.fromARGB(100, 0, 0, 0),
    ),
    const BoxShadow(
      color: Colors.white,
      spreadRadius: -4.0,
      blurRadius: 13.0,
    ),
  ];
}
