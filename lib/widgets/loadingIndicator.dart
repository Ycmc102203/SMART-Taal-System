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
          height: 225,
          width: 100,
          child: Center(
              child: Stack(children: [
            Center(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 30, color: color, fontWeight: FontWeight.bold)),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 15,
                    valueColor: new AlwaysStoppedAnimation<Color>(color),
                  ),
                ))
          ]))),
    );
  }
}
