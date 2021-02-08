import 'package:calendar/screen/Calendar/calendar.dart';

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
                return Calendar();
              },
            ),
          );
        },
      ),
    );
  }
}
