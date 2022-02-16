import 'package:flutter/material.dart';
import 'package:flutter_application_1/backend/google_sheets_api.dart';
import 'package:flutter_application_1/screens/form_page_one.dart';
import 'package:flutter_application_1/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Enumerator Profile',
        theme: ThemeData(primarySwatch: Colors.purple),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => MyHomePage(),
          //'/form_1': (BuildContext context) => addActivity(context),
        });
  }
}
