import 'dart:convert';

import 'package:calendar/constants.dart';
import 'package:calendar/data/Calendar.dart';
import 'package:calendar/screen/Main/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'APIget.dart';

List fuu;
List fuuu;
// int userIDK;
// int calhostNUM;

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
  final String localid;
  final int userIDK;
  final int hostNUM;
  WithFriend(
      {@required this.id,
      this.calendarNUM,
      this.scheduleTYPE,
      this.scheduleDETAIL,
      this.scheduleDATE,
      this.finishTIME,
      this.startTIME,
      this.scheduleLOCATION,
      @required this.isWrite,
      @required this.userIDK,
      @required this.hostNUM,
      @required this.localid});
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
  int hostNUM;
  int userIDK;
  bool write = false;

  Widget pickedFriend(friendList, write, userIDK, calendarNUM, calendarfriend) {
    int tmp = 0;

    print("friendList : $friendList");
    print("calendarfriend : $calendarfriend");
    friendList == null ? tmp = 0 : tmp = friendList.length;
    print("friendList:::::  ${friendList.length}");
    if (write) {
      if (calendarNUM != null) {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tmp,
            itemBuilder: (BuildContext context, int i) {
              if (_isChecked.length == friendList.length) {
              } else {
                for (int j = 0; j < calendarfriend.length; j++) {
                  if (friendList[i]["userIDK"] ==
                      calendarfriend[j]["userIDK"]) {
                    _isChecked.add(true);

                    break;
                  }
                  if (j == calendarfriend.length - 1) {
                    _isChecked.add(false);
                  }
                }
              }
              print(_isChecked);
              _friend.add("${friendList[i]["userID"]}");
              print("friendList :: $friendList");
              return CheckboxListTile(
                value: _isChecked[i],
                onChanged: (value) {
                  setState(() {
                    _isChecked[i] = value;
                    print(_isChecked);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "${friendList[i]["userNAME"]}",
                  style: TextStyle(color: Colors.white),
                ),
              );
            });
      } else {
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: tmp,
            itemBuilder: (BuildContext context, int i) {
              _isChecked.add(false);
              _friend.add("${friendList[i]["userID"]}");
              print("리뷰빌더 : $friendList[i]");
              return CheckboxListTile(
                checkColor: Colors.yellow[400],
                activeColor: Colors.white10,
                value: _isChecked[i],
                onChanged: (value) {
                  setState(() {
                    _isChecked[i] = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("${friendList[i]["userNAME"]}",
                    style: TextStyle(color: Colors.white70)),
              );
            });
      }
    } else {
      print("에바지");
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tmp,
        itemBuilder: (BuildContext context, int i) {
          if (friendList[i]["userIDK"] == userIDK) {
            print("$userIDK");
            return ListTile(
              title: Text(
                "${friendList[i]["userNAME"]}",
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(
                Icons.person_outline,
                color: Colors.white70,
              ),
            );
          } else {
            print("$userIDK");
            return ListTile(
              title: Text(
                "${friendList[i]["userNAME"]},",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }
        },
      );
    }
  }

  void addwithFriend(_isChecked, _friend) {
    if (_pickedfriend != null) {
      _pickedfriend.clear();
    }
    _pickedfriend.add(id);
    for (int i = 0; i < _isChecked.length; i++) {
      if (_isChecked[i]) {
        _pickedfriend.add(_friend[i]);
      }
    }
  }

  void submit(id, calendarNUM, schuduleTYPE, scheduleDETAIL, scheduleDATE,
      startTIME, finishTIME, scheduleLOCATION, _pickedfriend, hostNUM) async {
    if (hostNUM == null) {
      hostNUM = userIDK;
    }
    Calendar calendar = Calendar(null, scheduleTYPE, scheduleDETAIL,
        scheduleDATE, startTIME, finishTIME, scheduleLOCATION, hostNUM);
    for (int i = 0; i < _pickedfriend.length; i++) {
      calendar.setFriendLIST(_pickedfriend[i]);
    }
    print("calendar : ${calendar.getFriendLIST}");
    var json = jsonEncode(calendar);
    if (calendarNUM == null) {
      Response response = await post("$URL/insert/calendar",
          body: json, headers: {'Content-Type': "application/json"});
    } else if (calendarNUM != null) {
      Response response = await post("$URL/insert/calendar",
          body: json, headers: {'Content-Type': "application/json"});
      Response res = await delete("$URL/delete/calendar/$calendarNUM");
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;
    print(
        "withFriend 의 intitState의 calendarNUM, scheduleTYPE : ${widget.calendarNUM} , $scheduleTYPE");
    print("withFriend 의 intitState의  : $id");
    calendarNUM = widget.calendarNUM;
    scheduleTYPE = widget.scheduleTYPE;
    scheduleDETAIL = widget.scheduleDETAIL;
    scheduleDATE = widget.scheduleDATE;
    startTIME = widget.startTIME;
    finishTIME = widget.finishTIME;
    scheduleLOCATION = widget.scheduleLOCATION;
    write = widget.isWrite;
    print("withFriend 의 intitState의  : $userIDK");
    hostNUM = widget.hostNUM;
    userIDK = widget.userIDK;
    localid = widget.localid;
    fuu.clear();
    fuuu.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white10,
        title: write
            ? Text(
                "친구선택",
                style: TextStyle(color: Colors.white70),
              )
            : Text("함께하는 친구", style: TextStyle(color: Colors.white70)),
        centerTitle: true,
        actions: [
          write
              ? IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.red[600],
                  ),
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
                        _pickedfriend,
                        userIDK);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Mainmenu(id: id)),
                        (route) => false);
                  })
              : SizedBox(),
        ],
      ),
      body: FutureBuilder(
          future: write
              ? searchFriend(id, calendarNUM)
              : nochangedsearchFriend(calendarNUM, id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("여기는 바로바로바로바로바로 $fuuu");
              return pickedFriend(fuu, write, userIDK, calendarNUM, fuuu);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
