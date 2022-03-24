import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final text;
  final function;
  final icon;
  final color;
  final vertical;
  final fit;

  SubmitButton(
      {this.text,
      this.function,
      this.icon,
      this.color,
      this.vertical,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: vertical == null ? 20.0 : vertical, horizontal: 10),
        child: Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: color == null ? Colors.green : color,
                  blurRadius: 0.0,
                ),
              ],
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape:
                    MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                        (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.white, width: 5))),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                overlayColor: MaterialStateColor.resolveWith((states) =>
                    color == null ? Colors.lightGreen : Colors.redAccent),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 0;
                    return 15.0;
                  },
                ),
              ),
              onPressed: function,
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    fit: fit == null ? BoxFit.none : fit,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8), child: icon),
                        ]),
                  )),
            )));
  }
}
