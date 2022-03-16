import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

TextStyle headerStyle() {
  return TextStyle(fontWeight: FontWeight.w800, fontSize: 35);
}

TextStyle bodyStyle() {
  return TextStyle(fontSize: 18);
}

TextStyle bodyGreetingStyle() {
  return TextStyle(fontSize: 25);
}

TextStyle headerGradientStyle() {
  return TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 65,
      foreground: Paint()..shader = linearGradient);
}

Widget scrollPage(
    {required image,
    required context,
    required title,
    required body,
    required titleStyle,
    required bodyStyle,
    required textAlign}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(children: [
      Image.asset(image),
      Padding(
          padding: const EdgeInsets.all(25),
          child: RawScrollbar(
            radius: Radius.circular(10),
            thumbColor: Color.fromARGB(100, 76, 175, 79),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              padding: EdgeInsets.only(bottom: 80),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(children: [
                  Text(title, style: titleStyle),
                  SizedBox(height: 20),
                  Text(body, style: bodyStyle, textAlign: textAlign),
                  SizedBox(height: 100)
                ]),
              ),
            ),
          ))
    ]),
  );
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color.fromARGB(255, 226, 56, 4),
    Color.fromARGB(255, 255, 166, 0),
    Colors.lightBlue,
  ],
).createShader(Rect.fromLTWH(50.0, 200, 250, 20.0));

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return SafeArea(
        child: IntroductionScreen(
      rawPages: [
        scrollPage(
            image: "assets/onboarding/1.jpg",
            context: context,
            title: 'Mabuhay!',
            body: 'Maligayang pagdating sa SMARt Taal System, Enumerator!',
            titleStyle: headerGradientStyle(),
            bodyStyle: bodyGreetingStyle(),
            textAlign: TextAlign.center),
        scrollPage(
            image: "assets/onboarding/2.jpg",
            context: context,
            title: 'Ano ang SMARt Taal System?',
            body:
                'Ang SMARt Taal System ay isang sistema ng mga aplikasyon na nilalayong makatulong sa pangongolekta ng datos para sa konserbasyon ng lawa ng Taal',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/3.jpg",
            context: context,
            title: 'Paano ako nito matutulungan?',
            body:
                'Bilang isang Enumerator, ang SMARt Taal System ay makatutulong sa iyo sa pagtatala ng datos para sa pag-sa-Stock Assessment',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/4.jpg",
            context: context,
            title: 'Paano ako makakapagtala?',
            body:
                'Dito, pwede kang magdagdag ng mga tala ng mga bangka at mga sinample na isda sa pamamagitan ng pagsagot ng mga birtual na forms sa bawat pinuntahang mga lugar daungan',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/5.jpg",
            context: context,
            title: 'Paano ako makakapagtala?',
            body:
                'Ang forms na iyong sasagutan ay hango sa mga kinagisnan niyo nang NSAP forms, at ito ay pinasimple lamang para mas mabilis kayo makapagtala nang di kailangang umulit-ulit.',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/6.jpg",
            context: context,
            title: 'Saan mapupunta ang datos?',
            body:
                'Pagkatapos niyong sagutan ang forms para sa tala, ang datos ay deretsong mapupunta at maoorganisa sa isang Google Sheets na database kapag may internet. ',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/7.jpg",
            context: context,
            title: 'Paano kung wala akong internet?',
            body:
                'Kapag nagtala ka habang walang internet, pansamantala muna itong malalagay sa iyong device, at maaari mo itong ma-upload kapag may internet na.',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/8.jpg",
            context: context,
            title: 'Paano kung nagkamali\nako ng tala?',
            body:
                'Pwede mo ring mabalikan ang iyong mga nakaraang tala sa pamamagitan ng app na ito, at pwede mo rin silang i-edit o i-delete kung kinakailangan.',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/9.jpg",
            context: context,
            title: 'Paano kung hindi ko alam ang gagawin?',
            body:
                'Kung maligaw ka naman sa paggamit ng SMARt Taal System, huwag mag-alala! May nakahandang dokumentasyon para sa iyo sa paggamit ng lahat ng mga features ng app.',
            titleStyle: headerStyle(),
            bodyStyle: bodyStyle(),
            textAlign: TextAlign.start),
        scrollPage(
            image: "assets/onboarding/10.jpg",
            context: context,
            title: 'Tara!',
            body: 'Ano nang hinihintay mo,\nmagsimula na tayo!',
            titleStyle: headerGradientStyle(),
            bodyStyle: bodyGreetingStyle(),
            textAlign: TextAlign.center),
      ],
      globalBackgroundColor: Colors.white,
      scrollPhysics: BouncingScrollPhysics(),
      showNextButton: true,
      showBackButton: true,
      showSkipButton: false,
      next: const Icon(Icons.arrow_forward, color: Colors.green),
      back: const Icon(Icons.arrow_back, color: Colors.red),
      done: const Text("Magsimula!",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.green)),
      onDone: () {
        Navigator.popAndPushNamed(context, '/login');
      },
      dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              //   side: BorderSide(color: Colors.black),
              //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
              )),
      dotsDecorator: DotsDecorator(
          size: const Size.square(5.0),
          activeSize: const Size(15.0, 10.0),
          activeColor: Colors.green,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 2.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    ));
  }
}
