import 'package:flutter/material.dart';

class BackWarning extends StatelessWidget {
  const BackWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Babalik ka ba?",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            Icon(Icons.arrow_circle_left, color: Colors.red, size: 30)
          ],
        ),
        content: Text("Mawawala ang mga nasulat mo kung babalik ka ngayon."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Nagkamali ako ng pindot',
                style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Bumalik"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
            ),
          )
        ]);
  }
}
