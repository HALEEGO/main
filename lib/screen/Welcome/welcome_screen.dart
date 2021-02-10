// import 'package:calendar/screen/Calendar/tabBar.dart';

import 'package:calendar/screen/Main/mainmenu.dart';

import '../AddCalendar/addCalendar.dart';

import './components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Mainmenu();
              },
            ),
          );
        },
      ),
    );
  }
}
