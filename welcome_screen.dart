// import 'package:calendar/screen/Calendar/tabBar.dart';

import 'package:calendar/screen/Main/mainbody.dart';
import 'package:calendar/screen/Main/mainmenu.dart';

import './components/body.dart';
import 'package:flutter/material.dart';

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) {
//                 return MainBody();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
