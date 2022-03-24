import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_taal_system/backend/sqlfite_local_primary_db.dart';
import 'package:smart_taal_system/forms/fields/text_input_field.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:smart_taal_system/widgets/warnings/forgot_password.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../backend/models/user_model.dart';
import '../../backend/user_db.dart';
import '../../frontend/innershadow.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  Map _userData = {};
  final _passwordKey = GlobalKey<FormState>();
  bool _isObscureOne = false;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController verifyPassword = TextEditingController();

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

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    _queryUser();
    super.initState();
  }

  _queryUser() async {
    Database db = await DatabaseHelperThree.instance.database;
    List<Map> result = await db.rawQuery('SELECT * FROM userDataData');
    for (var x in result) {
      setState(() {
        _userData = x;
      });
    }
    print("print: ${_userData}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).size.height / 1.07)),
        child: RawScrollbar(
          thumbColor: Colors.green,
          radius: Radius.circular(50),
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    child: Container(
                      color: Colors.purple,
                      //elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Mga Settings',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                            Icon(
                              FontAwesomeIcons.cog,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mabuhay, ', style: TextStyle(fontSize: 30)),
                      Text('${_userData["nickname"]}!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        'Ang mga opsyon sa ilalim ay ang mga pagbabagong pwede mong gawin para sa iyong account sa SMARt Taal.',
                        style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                  SubmitButton(
                      text: "Paltan ang Password",
                      function: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                ForgotPassword());
                      },
                      icon: Icon(Icons.lock),
                      color: Colors.blue,
                      vertical: 0.0),
                  SubmitButton(
                      text: "I-Delete Lahat ng Datos",
                      function: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16.0))),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("BABALA",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.red,
                                              fontSize: 30)),
                                      Icon(Icons.warning_rounded,
                                          color: Colors.red, size: 40)
                                    ],
                                  ),
                                  content: Text(
                                      "Pag nagpatuloy ka dito, ma-dedelete lahat ng tala mo.\n\nMadedelete lang ang mga talang ito sa iyong cellphone, at hindi yung mga nasa GoogleSheets na database.\n\nHindi na maibabalik ang mga na-i-delete na datos, kaya siguraduhing alam ang susunod na gagawin."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Bumalik",
                                            style:
                                                TextStyle(color: Colors.red))),
                                    TextButton(
                                        onPressed: () {
                                          deleteAll();
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text("Oo, i-delete lahat")),
                                  ],
                                ));
                      },
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      vertical: 10.0),
                  SubmitButton(
                    text: "Mag-Log-out",
                    function: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Log-out?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            color: Colors.red,
                                            fontSize: 30)),
                                    Icon(Icons.warning_rounded,
                                        color: Colors.red, size: 40)
                                  ],
                                ),
                                content: Text(
                                    "Pag nagpatuloy ka dito, ikaw ay mag-lolog-out at ma-dedelete rin lahat ng tinala mo.\n\nMadedelete lang ang mga talang nasa iyong cellphone, at hindi yung mga nasa GoogleSheets na database.\n\nHindi na maibabalik ang mga na-i-delete na datos, kaya siguraduhing alam ang susunod na gagawin.\n\nPag nag-log-in ka muli, mag-sisimula ka muli nang walang datos."),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Bumalik",
                                          style: TextStyle(color: Colors.red))),
                                  TextButton(
                                      onPressed: () {
                                        deleteUserAll();
                                        deleteUser();
                                        deleteAll();
                                        setState(() {});
                                        logout(context);
                                        _queryUser();
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Text("Oo, mag-log-out")),
                                ],
                              ));
                    },
                    color: Colors.red,
                    icon: Icon(Icons.logout),
                    vertical: 0.0,
                  ),
                ]),
          ),
        ),
      ), // Center
    ); // Scaffold
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, '/login');
  }

  deleteAll() async {
    Database db = await DatabaseHelperOne.instance.database;
    return await db.rawDelete("DELETE from enumeratorLocalData");
  }

  deleteUserAll() async {
    Database dbTwo = await DatabaseHelperThree.instance.database;
    return await dbTwo.rawDelete("DELETE from userDataData");
  }

  deleteUser() async {
    await DatabaseHelperThree.instance.add(userData(
        firstName: '', lastName: '', nickname: '', status: 'logged out'));
  }
}
