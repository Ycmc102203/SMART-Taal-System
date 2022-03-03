import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final title;
  final content;
  final icon;
  final cancelText;
  final cancelAction;
  final okText;
  final okAction;
  final text;
  final actions;
  final padding;

  NextButton(
      {this.text,
      this.icon,
      this.title,
      this.content,
      this.cancelText,
      this.cancelAction,
      this.okText,
      this.okAction,
      this.actions,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                title: title,
                content: content,
                actions: actions)),
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
            Padding(padding: EdgeInsets.only(left: 8), child: icon)
          ]),
        ),
      ),
    );
  }
}
