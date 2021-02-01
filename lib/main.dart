import 'package:flutter/material.dart';
import './screen/ex.dart';
import './screen/pushPlan.dart';

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
