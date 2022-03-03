import 'package:flutter/material.dart';

class backAlertDialog extends StatelessWidget {
  final onPressedTrue;
  final onPressedFalse;

  backAlertDialog({this.onPressedTrue, this.onPressedFalse});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sigurado ka na ba sa mga nilagay mo?"),
      content: Text("Mawawala ang mga nasulat mo kung babalik ka ngayon"),
      actions: [
        TextButton(
          onPressed: onPressedTrue,
          child: Text('Nagkamali ako ng pindot',
              style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: onPressedFalse,
          child: Text("Oo, bumalik"),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.red,
          ),
        )
      ],
    );
  }
}
