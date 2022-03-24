import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  String _url =
      'https://drive.google.com/file/d/1aqzAekxP4TiUMCUPSpAsXA9sseUUulwa/view?usp=sharing';

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
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 1.07) +
                  10),
          child: RawScrollbar(
            thumbColor: Colors.green,
            thickness: 7,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Center(
                  child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      _launchUrl(_url);
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 5, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        elevation: 10,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 193,
                            child: Column(children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(130, 0, 0, 0),
                                      Colors.transparent
                                    ],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  'assets/Sardinella tawilis.PNG',
                                  height: 135,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                  color: Colors.white,
                                  height: 56,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Manwal sa paggamit ng",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "SMARt Taal System",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  ]),
                                              Icon(
                                                Icons.phone_android_rounded,
                                                size: 40,
                                                color: Color.fromARGB(
                                                    255, 195, 37, 26),
                                              )
                                            ],
                                          ))))
                            ]))),
                  ),
                  InkWell(
                    onTap: () {
                      _launchUrl(
                          "https://drive.google.com/file/d/1_zGRJ0VXwAoVKR0tsUef1qyzgq8RJv0f/view?usp=sharing");
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 5, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        elevation: 10,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 24, 168, 36),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 193,
                            child: Column(children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(130, 0, 0, 0),
                                      Colors.transparent
                                    ],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  'assets/Sardinella tawilis.PNG',
                                  height: 135,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                  color: Colors.white,
                                  height: 56,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Manwal sa pagsasagawa ng",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "Stock Assessment (NSAP)",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  ]),
                                              FaIcon(
                                                FontAwesomeIcons.edit,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 24, 168, 36),
                                              )
                                            ],
                                          ))))
                            ]))),
                  ),
                  InkWell(
                    onTap: () {
                      _launchUrl(
                          "https://docs.google.com/spreadsheets/d/e/2PACX-1vT5g0-XtYz0ljZm30g0rFxJBSScX9TBXeSaSzEJJWFrrY9RohMBnAIIYe9fRcMoYM4VSUrdXPiFYF0F/pubhtml?gid=857143555&single=true");
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 5, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        elevation: 10,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 33, 50, 204),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 193,
                            child: Column(children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(130, 0, 0, 0),
                                      Colors.transparent
                                    ],
                                  ).createShader(Rect.fromLTRB(
                                      0, 0, rect.width, rect.height));
                                },
                                blendMode: BlendMode.dstIn,
                                child: Image.asset(
                                  'assets/Sardinella tawilis.PNG',
                                  height: 135,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                  color: Colors.white,
                                  height: 56,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "SMARt Taal Enumerator Backend",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "Database Dashboard",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  ]),
                                              FaIcon(
                                                Icons.bar_chart,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 43, 26, 195),
                                              )
                                            ],
                                          ))))
                            ]))),
                  )
                ],
              )),
            ),
          ),
        )); // Scaffold
  }
}
