import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final text;
  final function;
  final icon;

  AddButton({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8),
        child: TextButton(
          onPressed: function,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(padding: EdgeInsets.only(left: 8), child: icon),
            ]),
          ),
        ));
  }
}
