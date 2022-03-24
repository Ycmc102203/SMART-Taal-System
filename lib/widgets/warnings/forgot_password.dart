import 'package:flutter/material.dart';

import '../buttons/submit_button.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0))),
      title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pagpapalit\nng Password     ",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blue,
                      fontSize: 30)),
              Icon(Icons.lock, color: Colors.blue, size: 40)
            ],
          )),
      content: RawScrollbar(
        thumbColor: Color.fromARGB(80, 76, 175, 79),
        radius: Radius.circular(10),
        isAlwaysShown: true,
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Text(
                  "Para masiguraduhan ang iyong seguridad, ang tanging paraan ng pagpapalit ng password ay sa pamamagitan ng pag-kontak sa admin ng SMARt Taal System.\n\nMangyaring mag-email lamang sa smarttaalsystem@gmail.com at sila na ang bahalang mag-reset ng password mo para sa iyo."),

              SizedBox(width: 800)
              //   Text(
              //       "Pag nagpatuloy ka dito, ma-dedelete lahat ng tala mo.\n\nMadedelete lang ang mga talang ito sa iyong cellphone, at hindi yung mga nasa GoogleSheets na database.\n\nHindi na maibabalik ang mga na-i-delete na datos, kaya siguraduhing alam ang susunod na gagawin."),
            ],
          ),
        ),
      ),
      actions: [
        SubmitButton(
            fit: BoxFit.fitWidth,
            text: "Naiintindihan ko",
            function: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.thumb_up_alt),
            color: Colors.blue)
      ],
    );
  }
}
