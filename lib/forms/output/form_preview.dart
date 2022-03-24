import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormPreview extends StatelessWidget {
  final children;
  final onPressed;
  const FormPreview({Key? key, required this.children, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(18, 18, 18, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sigurado ka na\nba sa nilagay mo?   ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            FaIcon(FontAwesomeIcons.solidCheckCircle,
                size: 40, color: Colors.green)
          ],
        ),
      ),
      content: RawScrollbar(
          thumbColor: Colors.green,
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Bago magpatuloy sa pagtala, siguraduhing tama ang mga detalye ukol sa pagtatalang ito",
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children))
              ],
            ),
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Bumalik'),
          child: Text('Bumalik', style: TextStyle(color: Colors.green)),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            "Oo, sigurado na ako",
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.green,
            //onSurface: Colors.grey,
          ),
        ),
      ],
    );
  }
}
