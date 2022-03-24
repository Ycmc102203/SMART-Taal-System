import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final text;
  final function;
  final icon;

  AddButton({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 70,
          width: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.green,
                blurRadius: 0.0,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white, width: 5))),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => Colors.lightGreen),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return 0;
                  return 15.0;
                },
              ),
            ),
            onPressed: function,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                ),
                Padding(padding: EdgeInsets.only(left: 8), child: icon),
              ]),
            ),
          ),
        ));
  }
}
