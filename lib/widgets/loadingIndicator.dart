import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  var color;
  var text;

  LoadingDialog({this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      content: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Center(
              child: Stack(children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width / 8.5,
              child: Text(text,
                  style: TextStyle(
                      fontSize: 40, color: color, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CircularProgressIndicator(
                  strokeWidth: 15,
                  valueColor: new AlwaysStoppedAnimation<Color>(color),
                ))
          ]))),
    );
  }
}
