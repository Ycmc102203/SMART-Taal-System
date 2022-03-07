import 'package:flutter/material.dart';

class PostOfflineWarning extends StatelessWidget {
  final onPressed;
  const PostOfflineWarning({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Offline ka parin",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Icon(Icons.wifi_off, size: 30, color: Colors.red)
          ],
        ),
        content: Text(
            "Hindi ka pa pala konektado sa internet. Pansamantala muna itong ma-ilalagay sa listahan ng mga di pa na-uupoad. Makikita mo ito sa Dashboard.\n\nPag may koneksyon ka na muli, i-refresh mo lang ang Dashboard para ma-upload ito sa Google Sheets Database"),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text("Oo, naiintindihan ko"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.green,
            ),
          )
        ]);
  }
}
