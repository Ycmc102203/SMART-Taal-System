import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final validator;
  final controller;
  final labelText;
  final keyboardType;

  const TextInputField(
      {Key? key,
      required this.validator,
      required this.controller,
      required this.labelText,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
      ),
      keyboardType: keyboardType,
    );
  }
}
