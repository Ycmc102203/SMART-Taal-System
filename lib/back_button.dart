import 'package:flutter/material.dart';

class backButton extends StatelessWidget {
  final title;
  final content;
  final icon;
  final cancelText;
  final cancelAction;
  final okText;
  final okAction;
  final text;
  final actions;
  final onPressed;

  backButton(
      {this.text,
      this.icon,
      this.title,
      this.content,
      this.cancelText,
      this.cancelAction,
      this.okText,
      this.okAction,
      this.actions,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.width / 10,
          width: MediaQuery.of(context).size.width / 10,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(padding: EdgeInsets.only(left: 3), child: icon),
          ]),
        ),
      ),
    );
  }
}
