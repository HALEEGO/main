import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screen/Welcome/welcome_screen.dart';
import 'constants.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // runApp(MyApp());
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.grey,
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: WelcomeScreen());
  }
}
