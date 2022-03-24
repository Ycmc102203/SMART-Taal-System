import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_taal_system/forms/input/arguments.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:sqflite/sqflite.dart';

import '../../backend/models/user_model.dart';
import '../../backend/user_db.dart';
import '../../widgets/loadingIndicator.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        this.loggedInUser = UserModel.fromMap(value.data());
      });
    });
    _postDetailsLocally(
        loggedInUser.firstName, loggedInUser.lastName, loggedInUser.nickname);
    super.initState();
  }

  void _postDetailsLocally(fName, lName, nName) async {
    await DatabaseHelperThree.instance.add(userData(
        firstName: fName,
        lastName: lName,
        nickname: nName,
        status: 'logged in'));
    Database db = await DatabaseHelperThree.instance.database;
    await db.rawUpdate(
        '''UPDATE userDataData SET firstName = ?, lastName = ?, nickname = ?, status = ? WHERE id = ?''',
        ['${fName}', '${lName}', '${nName}', 'logged in', 1]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingDialog(color: Colors.green, text: "Nagloload");
          } else {
            return Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_open, color: Colors.green, size: 80),
                    SizedBox(height: 40),
                    Text("Matagumpay ang iyong\npag-Log-In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800)),
                    SizedBox(height: 40),
                    Text("Pindutin ang butones sa\nibaba para magpatuloy",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    SubmitButton(
                        text: "Magpatuloy",
                        function: () {
                          _postDetailsLocally(loggedInUser.firstName,
                              loggedInUser.lastName, loggedInUser.nickname);
                          Navigator.popAndPushNamed(context, '/home');
                        }),
                  ],
                ),
              ),
            ));
          }
        });
  }
}
