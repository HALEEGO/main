import 'package:calendar/screen/Main/mainbody.dart';
import 'package:flutter/material.dart';

class Mainmenu extends StatelessWidget {
  final String id;
  Mainmenu({this.id});

  @override
  Widget build(BuildContext context) {
    return MainBody(id: id);
  }
}
