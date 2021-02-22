import 'dart:convert';

import 'package:calendar/data/Calendar.dart';
import 'package:calendar/screen/Main/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'APIget.dart';

List fuu;
List fuuu;
int userIDK;

class WithFriend extends StatefulWidget {
  final String id;
  final String calendarNUM;
  final String scheduleTYPE;
  final String scheduleDETAIL;
  final String scheduleDATE;
  final String startTIME;
  final String finishTIME;
  final String scheduleLOCATION;
  final bool isWrite;
  WithFriend(
      {@required this.id,
      this.calendarNUM,
      @required this.scheduleTYPE,
      @required this.scheduleDETAIL,
      @required this.scheduleDATE,
      this.finishTIME,
      this.startTIME,
      @required this.scheduleLOCATION,
      @required this.isWrite});
  @override
  _WithFriendState createState() => _WithFriendState();
}

class _WithFriendState extends State<WithFriend> {
  static final storage = new FlutterSecureStorage();
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
  String localid;
  bool write = false;

  void isMe(id) async {
    localid = await storage.read(key: "login");
    if (id == localid) {}
    print("object");
  }

  Widget pickedFriend(friendList, write, userIDK, calendarNUM, fuuu) {
    int tmp = 0;

    friendList == null ? tmp = 0 : tmp = friendList.length;
    if (write) {
      if (calendarNUM != null) {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tmp,
            itemBuilder: (BuildContext context, int i) {
              for (int j = 0; j < fuuu.length; j++) {
                if (friendList[i]["userIDK"] == fuuu[j]["userIDK"]) {
                  _isChecked.add(true);
                  break;
                }
              }
              _isChecked.add(false);
              _friend.add("${friendList[i]["userID"]}");
              return CheckboxListTile(
                value: _isChecked[i],
                onChanged: (value) {
                  setState(() {
                    _isChecked[i] = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("${friendList[i]["userNAME"]}"),
              );
            });
      } else {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tmp,
            itemBuilder: (BuildContext context, int i) {
              _isChecked.add(false);
              _friend.add("${friendList[i]["userID"]}");
              return CheckboxListTile(
                value: _isChecked[i],
                onChanged: (value) {
                  setState(() {
                    _isChecked[i] = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("${friendList[i]["userNAME"]}"),
              );
            });
      }
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tmp,
        itemBuilder: (BuildContext context, int i) {
          if (friendList[i]["userIDK"] == userIDK) {
            print("$userIDK");
            return ListTile(
              title: Text("${friendList[i]["userNAME"]}"),
              trailing: Icon(Icons.person_outline),
            );
          } else {
            print("$userIDK");
            return ListTile(
              title: Text("${friendList[i]["userNAME"]}"),
            );
          }
        },
      );
    }
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
      print(json);
      print(calendar.toJson());
      Response response = await post("$URL/insert/calendar",
          body: json, headers: {'Content-Type': "application/json"});
      print(response.body.toString());
    } else if (calendarNUM != null) {
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
    write = widget.isWrite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: write ? Text("친구선택") : Text("함께하는 친구"),
        centerTitle: true,
        actions: [
          write
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    addwithFriend(_isChecked, _friend);
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
                            builder: (BuildContext context) =>
                                Mainmenu(id: id)),
                        (route) => false);
                  })
              : Icon(Icons.access_alarm_rounded),
        ],
      ),
      body: FutureBuilder(
          future: write
              ? searchFriend(widget.id, calendarNUM)
              : nochangedsearchFriend(calendarNUM, id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return pickedFriend(fuu, write, userIDK, calendarNUM, fuuu);
            } else {
              return Container();
            }
          }),
    );
  }
}
