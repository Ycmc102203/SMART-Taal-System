import 'package:flutter/material.dart';

class BackWarning extends StatelessWidget {
  const BackWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text("Babalik ka ba?"),
        content: Text("Mawawala ang mga nasulat mo kung babalik ka ngayon"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Nagkamali ako ng pindot',
                style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Oo, bumalik"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
            ),
          )
        ]);
  }
}
