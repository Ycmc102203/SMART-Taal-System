import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final validator;
  final controller;
  final labelText;
  final keyboardType;
  final initialValue;
  final isObscure;
  final maxLength;

  const TextInputField(
      {Key? key,
      required this.validator,
      required this.controller,
      required this.labelText,
      required this.keyboardType,
      this.initialValue,
      this.isObscure,
      this.maxLength})
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
      initialValue: initialValue,
      obscureText: isObscure == null ? false : isObscure,
      maxLength: maxLength == null ? null : maxLength,
    );
  }
}
