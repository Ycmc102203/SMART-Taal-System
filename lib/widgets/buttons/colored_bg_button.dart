import 'package:flutter/material.dart';

class ColoredBgButton extends StatelessWidget {
  final title;
  final function;
  final color;
  final colorSelected;
  final size;
  final fontSize;
  final icon;

  const ColoredBgButton(
      {Key? key,
      required this.title,
      required this.function,
      required this.color,
      required this.colorSelected,
      required this.size,
      required this.fontSize,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: color,
                blurRadius: 0.0,
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              fixedSize:
                  MaterialStateProperty.resolveWith<Size>((states) => size),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white, width: 5))),
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => colorSelected),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return 0;
                  return 20.0;
                },
              ),
            ),
            onPressed: function,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: fontSize),
                      ),
                      icon
                    ]),
              ),
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
