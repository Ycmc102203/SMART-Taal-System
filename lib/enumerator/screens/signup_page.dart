import 'dart:io';
import 'package:animations/animations.dart';
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
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      //final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   return File(imagePath).copy(image.path);
  // }

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
                        backgroundImage: FileImage(image!)),
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
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ));
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
                                color: Colors.black,
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
                                  15),
                              formField(
                                  "Ulitin ang Password",
                                  Icon(Icons.lock),
                                  TextInputType.visiblePassword,
                                  confirmPassword,
                                  (value) => value.isEmpty
                                      ? 'Ulitin ang Password'
                                      : ((value == password)
                                          ? 'Hindi magkatugma ang password!'
                                          : null),
                                  // (passwordRegExp.hasMatch(value)
                                  //     ? null
                                  //     : 'Para masiguradong ligtas ang iyong account,\ndapat ang password ay:\n\n(1)  8-10 na karakter lang ang haba;\n(2)  Naglalaman ng malaking titik;\n(3)  Naglalaman ng maliit na titik;\n(4)  Naglalaman ng numero; at\n(5)  Naglalaman ng espesyal na karakter\n      (hal. @!%*?&)'),
                                  8,
                                  15),
                              SizedBox(height: 20),
                              formSection("Litrato (optional)",
                                  Icon(Icons.camera_alt, size: 35)),
                              SizedBox(height: 10),
                              image != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 85,
                                      child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 80,
                                          backgroundImage: FileImage(image!)),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 80,
                                      child:
                                          Image.asset("assets/Enumerator.png")),
                              SizedBox(height: 20),
                              ColoredBgButton(
                                  title: "Pumili sa Gallery",
                                  function: () {
                                    pickImage(ImageSource.gallery);
                                    print(image);
                                  },
                                  color: Colors.purple,
                                  colorSelected: Colors.purpleAccent,
                                  size: Size(
                                      MediaQuery.of(context).size.width / 1.15,
                                      70),
                                  fontSize: 20.0,
                                  icon: Icon(FontAwesomeIcons.image)),
                              SizedBox(height: 10),
                              ColoredBgButton(
                                  title: "Kumuha ng Litrato",
                                  function: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  color: Colors.purple,
                                  colorSelected: Colors.purpleAccent,
                                  size: Size(
                                      MediaQuery.of(context).size.width / 1.15,
                                      70),
                                  fontSize: 20.0,
                                  icon: Icon(FontAwesomeIcons.camera)),
                              SizedBox(height: 30),
                              formSection(
                                  "Pahintulot",
                                  Icon(FontAwesomeIcons.fileContract,
                                      size: 30)),
                              SizedBox(height: 10),
                              Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 5),
                                        boxShadow: innerShadow(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Background",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                SizedBox(height: 10),
                                                Text(
                                                    "Republic Act No. 10173, also known as the Data Privacy Act of 2012 (DPA), aims to protect personal data in information and communications systems both in the government and the private sector.\nIt ensures that entities or organizations processing personal data establish policies, and implement measures and procedures that guarantee the safety and security of personal data under their control or custody, thereby upholding an individual’s data privacy rights. A personal information controller or personal information processor is instructed to implement reasonable and appropriate measures to protect personal data against natural dangers such as accidental loss or destruction, and human dangers such as unlawful access, fraudulent misuse, unlawful destruction, alteration and contamination.\nTo inform its personnel of such measures, each personal information controller or personal information processor is expected to produce a Privacy Manual. The Manual serves as a guide or handbook for ensuring the compliance of an organization or entity with the DPA, its Implementing Rules and Regulations (IRR), and other relevant issuances of the National Privacy Commission (NPC). It also encapsulates the privacy and data protection protocols that need to be observed and carried out within the organization for specific circumstances (e.g., from collection to destruction), directed toward the fulfillment and realization of the rights of data subjects."),
                                              ]),
                                        ),
                                      ))),
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
}
