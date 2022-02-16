import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final text;
  final function;
  final icon;

  SubmitButton({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8),
      child: GestureDetector(
        onTap: function,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.green,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(left: 15), child: icon)
            ]),
          ),
        ),
      ),
    );
  }
}
