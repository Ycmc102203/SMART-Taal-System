import 'dart:io';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_taal_system/forms/fields/output_text_field.dart';
import 'package:smart_taal_system/forms/fields/text_input_field.dart';
import 'package:smart_taal_system/forms/output/form_preview.dart';
import 'package:smart_taal_system/frontend/innershadow.dart';
import 'package:smart_taal_system/widgets/buttons/add_button.dart';
import 'package:smart_taal_system/widgets/buttons/colored_bg_button.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:smart_taal_system/widgets/loadingIndicator.dart';
import 'package:smart_taal_system/widgets/warnings/forgot_password.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../backend/models/user_model.dart';
import '../../backend/user_db.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double coverHeight = 300;
  final double profileHeight = 45;
  bool checkedValue = false;
  File? image;
  final _signupKey = GlobalKey<FormState>();
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final _loginAuth = FirebaseAuth.instance;

  String? firstName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
        duration: Duration(milliseconds: 350),
        transitionBuilder: (child, animation, secondaryAnimation) =>
            FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child),
        child: Scaffold(
          backgroundColor: Colors.purple,
          body: buildTop(),
        ));
  }

  Widget formField(name, icon, keyboardType, controller, validator, minLength,
      maxLength, obscureText) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          boxShadow: innerShadow(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                labelText: name,
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: icon,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                filled: true,
                fillColor: Colors.transparent,
                focusColor: Colors.green),
          ),
        ),
      ),
      SizedBox(height: 10),
    ]);
  }

  Widget formSection(title, icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
        ),
        icon
      ],
    );
  }

  Widget buildTop() {
    return Container(
        child: Column(children: [
      Expanded(
          flex: 20,
          child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                    color: Colors.blue,
                    child: Image.asset(
                      'assets/Taal-Lake.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fitWidth,
                    )),
                Image.asset(
                  'assets/Enumerator.png',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 90, 10, 0),
                  child: FittedBox(
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "ENUMERATOR",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 500),
                    ),
                  ),
                )
              ])),
      Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              stops: [
                0.040,
                0.32,
                0.64,
                0.93,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFe74d3d),
                Color(0xFFe67e22),
                Color(0xFF9a59b5),
                Color(0xFF26ab5e),
              ],
            )),
          )),
      Expanded(
          flex: 10,
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        Text("LOG",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.orange,
                              fontSize: 150,
                            )),
                        Text("-",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 150)),
                        Text("IN",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.green,
                                fontSize: 150)),
                      ],
                    )),
              ))),
      Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              stops: [
                0.040,
                0.32,
                0.64,
                0.93,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFe74d3d),
                Color(0xFFe67e22),
                Color(0xFF9a59b5),
                Color(0xFF26ab5e),
              ],
            )),
          )),
      Expanded(
          flex: 70,
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _signupKey,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              formSection("Detalye ng Account",
                                  Icon(Icons.account_box, size: 35)),
                              SizedBox(height: 10),
                              formField(
                                  "Email",
                                  Icon(Icons.email),
                                  TextInputType.emailAddress,
                                  email,
                                  (value) => value.isEmpty
                                      ? 'Ilagay ang email'
                                      : (emailRegExp.hasMatch(value)
                                          ? null
                                          : 'Hindi valid ang email na nilagay. Siguraduhing\nkumpleto at tama ang email na nilagay mo dito\n\n halimbawa: juandelacruz@email.com'),
                                  1,
                                  null,
                                  false),
                              formField(
                                  "Password",
                                  Icon(Icons.lock),
                                  TextInputType.visiblePassword,
                                  password,
                                  (value) => value.isEmpty
                                      ? 'Ilagay ang password'
                                      : (passwordRegExp.hasMatch(value)
                                          ? null
                                          : 'Para masiguradong ligtas ang iyong\naccount, dapat ang password ay:\n\n(1)  8-15 na karakter lang ang haba;\n(2)  Naglalaman ng malaking titik;\n(3)  Naglalaman ng maliit na titik;\n(4)  Naglalaman ng numero; at\n(5)  Naglalaman ng espesyal na\n       karakter (hal. @!%*?&)'),
                                  8,
                                  15,
                                  true),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                ForgotPassword());
                                        print("Nakalimutan ang Password");
                                      },
                                      child: Text(
                                        "Nalimutan ang Password?",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
                                        textAlign: TextAlign.right,
                                      ))
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ColoredBgButton(
                            title: "Mag-Log-In",
                            function: () async {
                              if (_signupKey.currentState!.validate()) {
                                showDialog(
                                    context: context,
                                    builder: (context) => LoadingDialog(
                                        color: Colors.green,
                                        text: "Nag-lolog-in"));
                                await _loginAuth
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text)
                                    .then((uid) => {
                                          showTopSnackBar(
                                              context,
                                              CustomSnackBar.success(
                                                message:
                                                    "Mabuhay! Login Successful. Maligayang pagdating muli!",
                                              )),
                                        })
                                    .catchError((e) {
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message: e!.message,
                                      ));
                                });
                                Navigator.popAndPushNamed(
                                    context, '/transition');
                                //Navigator.popAndPushNamed(context, '/home');
                              } else {
                                showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "May kulang pa sa iyong tala. I-double check kung may laman na lahat.",
                                    ));
                              }
                            },
                            color: Colors.green,
                            colorSelected: Colors.lightGreen,
                            size: Size(
                                MediaQuery.of(context).size.width / 1.15, 80),
                            fontSize: 30.0,
                            icon: Icon(Icons.login, size: 35)),
                        SizedBox(height: 20),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              "Wala pang account?\nPindutin ito para mag-Sign-Up",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ))
                      ]),
                )),
          ))
    ]));
  }

  void _postDetailsLocally(fName, lName, nName) async {
    Database db = await DatabaseHelperThree.instance.database;
    await db.rawUpdate(
        '''UPDATE userDataData SET firstName = ?, lastName = ?, nickname = ?, status = ? WHERE id = ?''',
        ['${fName}', '${lName}', '${nName}', 'logged in', 1]);
    setState(() {});
  }
}
