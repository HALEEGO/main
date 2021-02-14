import 'package:flutter/material.dart';
import 'components/body.dart';

class Friendscreen extends StatefulWidget {
  final String id;
  Friendscreen({this.id});
  @override
  _FriendscreenState createState() => _FriendscreenState();
}

class _FriendscreenState extends State<Friendscreen> {
  String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    print("여기는 $id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(id: id),
    );
  }
}
