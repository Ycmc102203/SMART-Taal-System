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
import 'package:smart_taal_system/backend/models/user_model.dart';
import 'package:smart_taal_system/forms/fields/output_text_field.dart';
import 'package:smart_taal_system/forms/fields/text_input_field.dart';
import 'package:smart_taal_system/forms/output/form_preview.dart';
import 'package:smart_taal_system/frontend/innershadow.dart';
import 'package:smart_taal_system/widgets/buttons/add_button.dart';
import 'package:smart_taal_system/widgets/buttons/colored_bg_button.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../backend/user_db.dart';
import '../../widgets/loadingIndicator.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final double coverHeight = 300;
  final double profileHeight = 45;
  bool checkedValue = false;
  File? image;
  final _signupKey = GlobalKey<FormState>();
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$');

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nickname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _isObscureOne = true;
  bool _isObscureTwo = true;
  final _signupAuth = FirebaseAuth.instance;

  _showRegistrationPreview(BuildContext context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => FormPreview(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 85,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : AssetImage('assets/Enumerator.png')
                                as ImageProvider),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Personal na Detalye",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Icon(Icons.person, color: Colors.black)
                    ],
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  OutputTextField(
                      label: Text("First Name"), content: "${firstName.text}"),
                  SizedBox(height: 20),
                  OutputTextField(
                      label: Text("Last Name"), content: "${lastName.text}"),
                  SizedBox(height: 20),
                  OutputTextField(
                      label: Text("Palayaw/Nickname"),
                      content: "${nickname.text}"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Detalye ng Account",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 20),
                      ),
                      Icon(Icons.person, color: Colors.black)
                    ],
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  OutputTextField(
                      label: Text("Email"), content: "${email.text}"),
                  SizedBox(height: 20),
                  OutputTextField(
                      label: Text("Password"), content: "${password.text}"),
                ],
              ),
            ],
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) => LoadingDialog(
                      color: Colors.green, text: "Nag-si-sign-up"));
              await _signupAuth
                  .createUserWithEmailAndPassword(
                      email: email.text.trim(), password: password.text.trim())
                  .then((value) => {
                        postDetailsToFirestore(),
                      })
                  .catchError((e) {
                showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                      message: e!.message,
                    ));
              });
              _postDetailsLocally(firstName.text, lastName.text, nickname.text);
            },
          ));

  void _launchUrl(url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
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

  Widget formField(
      name, icon, keyboardType, controller, validator, minLength, maxLength) {
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

  Widget formFieldPasswordOne(
      name, icon, keyboardType, controller, validator, minLength, maxLength) {
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
            obscureText: _isObscureOne,
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            validator: validator,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscureOne ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscureOne = !_isObscureOne;
                    });
                  },
                ),
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

  Widget formFieldPasswordTwo(
      name, icon, keyboardType, controller, validator, minLength, maxLength) {
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
            obscureText: _isObscureTwo,
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            validator: validator,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscureTwo ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscureTwo = !_isObscureTwo;
                    });
                  },
                ),
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
                        Text("SIGN",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.orange,
                              fontSize: 150,
                            )),
                        Text("-",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.purple,
                                fontSize: 150)),
                        Text("UP",
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
            physics: BouncingScrollPhysics(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _signupKey,
                          child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 15),
                                      Icon(
                                        Icons.login_rounded,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "May account ka na ba?\nPindutin ito para mag-Log-In",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(width: 16),
                                    ],
                                  )),
                              SizedBox(height: 10),
                              formSection("Personal na Detalye",
                                  Icon(Icons.person, size: 35)),
                              SizedBox(height: 10),
                              formField(
                                  "First Name",
                                  null,
                                  TextInputType.name,
                                  firstName,
                                  (value) => value.isEmpty
                                      ? 'Ilagay ang first name'
                                      : (nameRegExp.hasMatch(value)
                                          ? null
                                          : 'Hindi valid ang pangalang nilagay. \nIwasang gumamit ng ibang karakter\nmaliban sa mga letra.'),
                                  1,
                                  null),
                              formField(
                                  "Last Name",
                                  null,
                                  TextInputType.name,
                                  lastName,
                                  (value) => value.isEmpty
                                      ? 'Ilagay ang apelyido'
                                      : (nameRegExp.hasMatch(value)
                                          ? null
                                          : 'Hindi valid ang pangalang nilagay. \nIwasang gumamit ng ibang karakter\nmaliban sa mga letra.'),
                                  1,
                                  null),
                              formField(
                                  "Palayaw/Nickname",
                                  null,
                                  TextInputType.name,
                                  nickname,
                                  (value) => value.isEmpty
                                      ? 'Ilagay ang palayaw para alam ng app\nkung paano ka tatawagin'
                                      : (nameRegExp.hasMatch(value)
                                          ? null
                                          : 'Hindi valid ang pangalang nilagay. \nIwasang gumamit ng ibang karakter\nmaliban sa mga letra o `-` at `.`'),
                                  1,
                                  15),
                              SizedBox(height: 20),
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
                                  null),
                              formFieldPasswordOne(
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
                                  15),
                              formFieldPasswordTwo(
                                  "Ulitin ang Password",
                                  Icon(Icons.lock),
                                  TextInputType.visiblePassword,
                                  confirmPassword,
                                  (value) => value.isEmpty
                                      ? 'Ulitin ang Password'
                                      : ((value == password.text)
                                          ? null
                                          : 'Hindi magkatugma ang password!'),
                                  // (passwordRegExp.hasMatch(value)
                                  //     ? null
                                  //     : 'Para masiguradong ligtas ang iyong account,\ndapat ang password ay:\n\n(1)  8-10 na karakter lang ang haba;\n(2)  Naglalaman ng malaking titik;\n(3)  Naglalaman ng maliit na titik;\n(4)  Naglalaman ng numero; at\n(5)  Naglalaman ng espesyal na karakter\n      (hal. @!%*?&)'),
                                  8,
                                  15),
                              SizedBox(height: 20),
                              formSection(
                                  "Pahintulot",
                                  Icon(FontAwesomeIcons.fileContract,
                                      size: 30)),
                              SizedBox(height: 10),
                              SubmitButton(
                                text: "Terms and Conditions",
                                icon: Icon(FontAwesomeIcons.wpforms,
                                    color: Colors.white),
                                color: Colors.blue,
                                function: () {
                                  _launchUrl(
                                      "https://docs.google.com/document/d/e/2PACX-1vQtcmo4T1mQBqfPXWwwj3CS1E_umVKkxHrZTNxx45i_u0T4NfIlck2Uh7-cUO0nFs6GlaJ99MylMvIU/pub");
                                },
                                vertical: 5.0,
                              ),
                              SubmitButton(
                                text: "Privacy policy",
                                color: Colors.blue,
                                icon: Icon(
                                  Icons.privacy_tip,
                                  color: Colors.white,
                                ),
                                function: () {
                                  _launchUrl(
                                      "https://docs.google.com/document/d/e/2PACX-1vQtEWN1f_Vf5tBpP-tahR3yCoF5zIH07xi17-Y5s3oKLG1LVdL_9qQz5cRDKRLy_dZQO0VwPX-MJu7A/pub");
                                },
                                vertical: 5.0,
                              ),
                              CheckboxListTile(
                                  activeColor: Colors.white,
                                  checkColor: Colors.purple,
                                  contentPadding: EdgeInsets.all(10),
                                  title: Text(
                                    "Naiintindihan ko ang lahat ng nakasaad dito",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: checkedValue,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      checkedValue = !checkedValue;
                                    });
                                    print(checkedValue);
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        checkedValue
                            ? ColoredBgButton(
                                title: "Mag-Sign-Up",
                                function: () {
                                  if (_signupKey.currentState!.validate()) {
                                    _showRegistrationPreview(context);
                                    print("lol");
                                    //Navigator.popAndPushNamed(context, '/home');
                                  } else {
                                    print(password.text);
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          message:
                                              "May kulang o mali pa sa iyong mga nilagay. I-double check kung may laman na lahat.",
                                        ));
                                  }
                                },
                                color: Colors.green,
                                colorSelected: Colors.lightGreen,
                                size: Size(
                                    MediaQuery.of(context).size.width / 1.15,
                                    80),
                                fontSize: 30.0,
                                icon: Icon(Icons.app_registration_rounded,
                                    size: 35))
                            : SizedBox(),
                        SizedBox(height: 10),
                      ]),
                )),
          ))
    ]));
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _signupAuth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstName.text;
    userModel.lastName = lastName.text;
    userModel.nickname = nickname.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    // showTopSnackBar(
    //     context,
    //     CustomSnackBar.success(
    //       message: "Nagawa na ang iyong account!",
    //     ));
    Navigator.popAndPushNamed(context, '/verify_email');
  }

  void _postDetailsLocally(fName, lName, nName) async {
    await DatabaseHelperThree.instance.add(userData(
        firstName: fName,
        lastName: lName,
        nickname: nName,
        status: 'logged in'));

    // Database db = await DatabaseHelperThree.instance.database;

    // await db.rawUpdate(
    //     '''UPDATE userDataData SET firstName = ?, lastName = ?, nickname = ?, status = ? WHERE id = ?''',
    //     ['${fName}', '${lName}', '${nName}', 'logged in', 1]);
    // setState(() {});
  }
}
