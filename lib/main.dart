import 'package:flutter/material.dart';
import 'screen/PushPlan/pushPlan.dart';
import './screen/Welcome/welcome_screen.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: 'snsCalendar',
        color: Colors.grey,
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: WelcomeScreen());
  }
}
