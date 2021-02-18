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
  var _isChecked = List<bool>();

  Widget pickedFriend(
    friendList,
  ) {
    bool vr = false;
    print("리스트만들기 시작");
    int tmp = 0;
    print("${friendList}");

    friendList == null ? tmp = 0 : tmp = friendList.length;
    print("리스트만들기끝");
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tmp,
        itemBuilder: (BuildContext context, int i) {
          _isChecked.add(true);
          return CheckboxListTile(
            value: _isChecked[i],
            onChanged: (value) {
              print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ$value ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
              setState(() {
                _isChecked[i] = value;
                print("mmmmmmmmmmmmmmmmmmmmmmmmm$_isChecked mmmmmmmmmmmmmmmmm");
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            title: Text("${friendList[i]["userNAME"]}"),
          );
        });
  }

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
              return pickedFriend(
                fuu,
              );
            } else {
              print("퓨쳐빌더 엘스문 시작");
              return Container();
            }
          }),
    );
  }
}
