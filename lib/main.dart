import 'package:flutter/material.dart';
import 'package:calendar/screen/pushPlan.dart';
import 'package:calendar/screen/ex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'snsCalendar',
      color: Colors.grey,
      home: PushPlan(),
    );
  }
}
