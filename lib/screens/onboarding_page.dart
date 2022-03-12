import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'Mabuhay!',
              body: 'Maligayang pagdating sa SMARt Taal System!'),
          PageViewModel(
              title: 'Mabuhay!',
              body:
                  'Ang SMARt Taal System ay tulong para sa pagtatala ng inyong datos na kinakailangan sa mga Stock Assessment'),
          PageViewModel(
              title: 'Mabuhay!',
              body:
                  'Dito, pwede mong itala ang mga dumaong na bangka sa lugar daungan, kung gaano karami ang nahuli nila, ku'),
          PageViewModel(
              title: 'Mabuhay!',
              body: 'Maligayang pagdating sa SMARt Taal System!'),
          PageViewModel(
              title: 'Mabuhay!',
              body: 'Maligayang pagdating sa SMARt Taal System!'),
        ],
        done: Text('Magpatuloy'),
        onDone: () {
          print('Done!');
          Navigator.popAndPushNamed(context, '/login');
        },
        showNextButton: false,
      ));
}
