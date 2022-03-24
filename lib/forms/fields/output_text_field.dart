import 'package:flutter/material.dart';
import 'package:path/path.dart';

class OutputTextField extends StatelessWidget {
  final content;
  final label;
  const OutputTextField({Key? key, this.content, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            labelStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    BorderSide(color: Color.fromARGB(35, 0, 0, 0), width: 1)),
            contentPadding: EdgeInsets.fromLTRB(10, 8, 5, 5),
            label: label),
        enabled: false,
        controller: TextEditingController(text: content));
  }
}
