import 'dart:convert';

import 'package:calendar/data/Calendar.dart';
import 'package:calendar/screen/Home/home_screen.dart';
import 'package:calendar/screen/Main/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'APIget.dart';

var fu = List<dynamic>();
List fuu;

class WithFriend extends StatefulWidget {
  final String id;
  final String calendarNUM;
  final String scheduleTYPE;
  final String scheduleDETAIL;
  final String scheduleDATE;
  final String startTIME;
  final String finishTIME;
  final String scheduleLOCATION;
  WithFriend(
      {@required this.id,
      this.calendarNUM,
      @required this.scheduleTYPE,
      @required this.scheduleDETAIL,
      @required this.scheduleDATE,
      this.finishTIME,
      this.startTIME,
      @required this.scheduleLOCATION});
  @override
  _WithFriendState createState() => _WithFriendState();
}

class _WithFriendState extends State<WithFriend> {
  String URL = "http://3.35.39.202:8000/calendar";
  var _isChecked = List<bool>();
  var _friend = List<String>();
  var _pickedfriend = List<String>();
  String id;
  String calendarNUM;
  String scheduleTYPE;
  String scheduleDETAIL;
  String scheduleDATE;
  String startTIME;
  String finishTIME;
  String scheduleLOCATION;

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
          _isChecked.add(false);
          _friend.add("${friendList[i]["userID"]}");
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

  void addwithFriend(_isChecked, _friend) {
    _pickedfriend.add(id);
    for (int i = 0; i < _isChecked.length; i++) {
      _isChecked[i] == true ? _pickedfriend.add(_friend[i]) : {};
    }
  }

  void submit(id, calendarNUM, schuduleTYPE, scheduleDETAIL, scheduleDATE,
      startTIME, finishTIME, scheduleLOCATION, _pickedfriend) async {
    if (calendarNUM == null) {
    } else {
      calendarNUM = int.parse(calendarNUM);
    }
    Calendar calendar = Calendar(
      null,
      scheduleTYPE,
      scheduleDETAIL,
      scheduleDATE,
      startTIME,
      finishTIME,
      scheduleLOCATION,
    );
    for (int i = 0; i < _pickedfriend.length; i++) {
      calendar.setFriendLIST(_pickedfriend[i]);
    }

    print(_pickedfriend);
    print(calendar.getFriendLIST);
    var json = jsonEncode(calendar);
    if (calendarNUM == null) {
      print("얜가요?");
      print(json);
      print(calendar.toJson());
      Response response = await post("$URL/insert/calendar",
          body: json, headers: {'Content-Type': "application/json"});
      print(response.body.toString());
    } else if (calendarNUM != null) {
      print("얠까요?");
      Response response = await post("$URL/insert/calendar",
          body: json, headers: {'Content-Type': "application/json"});
      Response res = await delete("$URL/delete/calendar/$calendarNUM");
      print(res.body);
      print(response.body.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;
    calendarNUM = widget.calendarNUM;
    scheduleTYPE = widget.scheduleTYPE;
    scheduleDETAIL = widget.scheduleDETAIL;
    scheduleDATE = widget.scheduleDATE;
    startTIME = widget.startTIME;
    finishTIME = widget.finishTIME;
    scheduleLOCATION = widget.scheduleLOCATION;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("함께할 친구"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                print("object");
                addwithFriend(_isChecked, _friend);
                print("object");
                submit(
                    id,
                    calendarNUM,
                    scheduleTYPE,
                    scheduleDETAIL,
                    scheduleDATE,
                    startTIME,
                    finishTIME,
                    scheduleLOCATION,
                    _pickedfriend);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Mainmenu(id: id)),
                    (route) => false);
              })
        ],
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
