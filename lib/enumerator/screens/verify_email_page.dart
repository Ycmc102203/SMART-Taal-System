import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_taal_system/enumerator/screens/home_page.dart';
import 'package:smart_taal_system/forms/input/arguments.dart';
import 'package:smart_taal_system/widgets/buttons/submit_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../backend/models/user_model.dart';
import '../../../backend/user_db.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  UserModel loggedInUser = UserModel();
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      showTopSnackBar(context, CustomSnackBar.error(message: e.toString()));
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
      showTopSnackBar(
          context,
          CustomSnackBar.success(
              message: "Nagawa at verified na ang iyong account!"));
    }
    ;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isEmailVerified
                  ? Icon(Icons.mark_email_read, color: Colors.green, size: 100)
                  : Icon(Icons.email, color: Colors.green, size: 100),
              SizedBox(height: 40),
              isEmailVerified
                  ? Text("Na-verify na ang iyong email!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w800))
                  : Text("I-check ang iyong email",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
              SizedBox(height: 40),
              isEmailVerified
                  ? Text(
                      "Maaari ka nang magpatuloy sa paggamit ng SMARt Taal System!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20))
                  : Text(
                      "I-check ang email kung may na-receive nang verification, nang sa gayon ay alam naming ikaw talaga ang gumawa ng account mo.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              isEmailVerified
                  ? SubmitButton(
                      text: "Magpatuloy",
                      icon: Icon(Icons.arrow_right_alt_rounded, size: 30),
                      function: () {
                        Navigator.popAndPushNamed(context, '/home');
                      })
                  : Column(
                      children: [
                        canResendEmail
                            ? Column(
                                children: [
                                  Text(
                                      "Kung wala ka pang natatanggap, pwede mong ipa-resend ang email sa pamamagitan ng butones sa ibaba.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20)),
                                  SubmitButton(
                                      text: "I-resend ang verification",
                                      icon: Icon(Icons.mark_email_unread),
                                      function: () {
                                        sendVerificationEmail();
                                      }),
                                ],
                              )
                            : SizedBox()
                      ],
                    ),
            ],
          ),
        ),
      ));
}
