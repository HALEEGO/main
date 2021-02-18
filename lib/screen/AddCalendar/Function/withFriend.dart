import 'package:calendar/data/Friend.dart';
import 'package:calendar/screen/AddCalendar/Function/body.dart';
import 'package:flutter/material.dart';
import 'APIget.dart';

var fu = List<dynamic>();
List fuu;

class WithFriend extends StatefulWidget {
  final String id;
  WithFriend({@required this.id});
  @override
  _WithFriendState createState() => _WithFriendState();
}

class _WithFriendState extends State<WithFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("함께할 친구"),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: FutureBuilder(
          future: searchFriend(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("퓨쳐빌더 시작");
              return pickedFriend(fuu);
            } else {
              print("퓨쳐빌더 엘스문 시작");
              return Container();
            }
          }),
    );
  }
}
