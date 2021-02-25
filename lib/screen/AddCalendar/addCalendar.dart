import 'dart:convert';

import 'package:calendar/constants.dart';
import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../../data/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddCalendar extends StatefulWidget {
  final String title; //scheduleTYPE
  final String calendarNUM;
  final String id;
  final String scheduleDATE;
  AddCalendar(
      {@required this.title,
      this.calendarNUM,
      @required this.id,
      this.scheduleDATE});

  @override
  _AddCalendarState createState() => _AddCalendarState();
}

class _AddCalendarState extends State<AddCalendar> {
  static final storage = new FlutterSecureStorage();
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  bool autovalidate = false;
  String id; //userid
  String title; //scheduleTYPE
  String calendarNUM;
  String scheduleTYPE,
      scheduleDETAIL,
      scheduleDATE,
      startTIME,
      finishTIME,
      scheduleLOCATION;
  int userIDK;
  int hostNUM;
  String localid;
  bool write = false;
  bool tmp = true;
  @override
  void initState() {
    super.initState();
    title = widget.title;
    id = widget.id;
    datecontroller = TextEditingController(text: "${widget.scheduleDATE}");
    calendar.setFriendLIST(id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isMe(id);
    });
    if (widget.calendarNUM != null) {
      print(widget.calendarNUM);
      calendarNUM = widget.calendarNUM;
    }
  }

  void isMe(id) {
    print("씨ㅡ발$userIDK");
    print("씨ㅡ발$hostNUM");

    if (calendarNUM == null) {
      write = true;
      tmp = true;
    } else {
      if (userIDK == hostNUM) {
        tmp = true;
      } else {
        tmp = false;
      }
    }
    if (localid != id) {
      tmp = false;
    }
  }

  final String URL = "http://3.35.39.202:8000/calendar";
  Future<String> api(id) async {
    print(id);
    Response re = await get("$URL/read/user/$id"); // 유저정보
    userIDK = jsonDecode(re.body)["userIDK"]; //userIDK
    print("kakndsalkdnsalkdnladksnldskandlaknadslkdnalkdasnlksdan $userIDK");
    localid = await storage.read(key: "login"); // 로그인시 저장했던 id
    if (calendarNUM != null) {
      Response response = await get("$URL/read/calendar/$calendarNUM");
      Map<String, dynamic> resMAP = jsonDecode(response.body);
      scheduleTYPEcontroller =
          TextEditingController(text: "${resMAP["scheduleTYPE"]}");
      scheduleDETAILcontroller =
          TextEditingController(text: "${resMAP["scheduleDETAIL"]}");
      scheduleLOCATIONcontroller =
          TextEditingController(text: "${resMAP["scheduleLOCATION"]}");
      datecontroller = TextEditingController(text: "${resMAP["scheduleDATE"]}");
      starttimecontroller =
          TextEditingController(text: "${resMAP["startTIME"]}");
      finishtimecontroller =
          TextEditingController(text: "${resMAP["finishTIME"]}");
      if (resMAP["hostNUM"] != null) {
        print(
            "kakndsalkdnsalkdnladksnldskandlaknadslkdnalkdasnlksdan $userIDK");
        hostNUM = resMAP["hostNUM"];
      }
      // hostNUM
      print(hostNUM);
      print("object");
      localid = await storage.read(key: "login"); // 로그인시 저장했던 id
      return "a";
    } else {
      return "b";
    }
  }

  Calendar calendar = Calendar(null, null, null, null, null, null, null, null);
  TextEditingController scheduleTYPEcontroller = TextEditingController();
  TextEditingController scheduleDETAILcontroller = TextEditingController();
  TextEditingController scheduleLOCATIONcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController finishtimecontroller = TextEditingController();

  bool allDaySwitch = false; //하루종일,알람 스위치버튼
  bool endTimeisSwitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
        title: Text(
          '$title',
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        actions: [
          calendarNUM == null || write
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    print(userIDK);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WithFriend(
                                  id: id,
                                  calendarNUM: calendarNUM,
                                  // scheduleDATE: scheduleDATE,
                                  // scheduleTYPE: scheduleTYPE,
                                  // scheduleDETAIL: scheduleDETAIL,
                                  // scheduleLOCATION: scheduleLOCATION,
                                  // startTIME: startTIME,
                                  // finishTIME: finishTIME,
                                  isWrite: write,
                                  hostNUM: hostNUM,
                                  userIDK: userIDK,
                                  localid: localid,
                                )));
                  }),
          calendarNUM == null
              ? SizedBox()
              : IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    isMe(id);
                    if (tmp) {
                      setState(() {
                        write = !write;
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            title: new Text("변경할수 없음"),
                            content: SingleChildScrollView(
                                child: new Text("내 일정이 아닙니다.")),
                          );
                        },
                      );
                    }
                  })
        ],
      ),
      body: FutureBuilder(
          future: api(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _fKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      maxLength: 20,
                      cursorColor: Colors.white,
                      controller: scheduleTYPEcontroller,
                      enabled: write,
                      decoration: InputDecoration(
                          labelText: '일정제목',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          icon: Icon(
                            Icons.title,
                            color: Colors.white70,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      onSaved: (val) {
                        scheduleTYPE = scheduleTYPEcontroller.text;
                        print(scheduleTYPE);
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해야합니다.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLength: 20,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      controller: scheduleDETAILcontroller,
                      enabled: write,
                      decoration: InputDecoration(
                          labelText: '일정내용',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          icon: Icon(
                            Icons.library_books_outlined,
                            color: Colors.white70,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      onSaved: (val) {
                        scheduleDETAIL = scheduleDETAILcontroller.text;
                        print(scheduleDETAIL);
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해야합니다.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      maxLength: 20,
                      controller: scheduleLOCATIONcontroller,
                      enabled: write,
                      decoration: InputDecoration(
                          labelText: '위치',
                          labelStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.white70,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white10),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      onSaved: (val) {
                        scheduleLOCATION = scheduleLOCATIONcontroller.text;
                        print(scheduleLOCATION);
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '입력해야합니다.';
                        }
                        return null;
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.timer,
                        color: Colors.white70,
                      ),
                      title: Text(
                        '하루종일',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Switch(
                        activeColor: Colors.green[600],
                        value: allDaySwitch,
                        onChanged: (value) {
                          if (write) {
                            setState(() {
                              allDaySwitch = value;
                            });
                          } else {}
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.timer,
                        color: Colors.white70,
                      ),
                      title: Text(
                        '종료시간 설정하기',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Switch(
                        activeColor: Colors.green[600],
                        value: endTimeisSwitch,
                        onChanged: (value) {
                          if (write) {
                            setState(() {
                              endTimeisSwitch = value;
                            });
                          } else {}
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.schedule,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: GestureDetector(
                            onTap: () {
                              write ? yearMonthDayPicker() : {};
                            },
                            child: AbsorbPointer(
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                controller: datecontroller,
                                decoration: InputDecoration(
                                    labelText: '날짜선택',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white))),
                                onSaved: (val) {
                                  scheduleDATE = datecontroller.text;
                                  print(scheduleDATE);
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return '입력해야합니다.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    allDaySwitch
                        ? new Container()
                        : Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.schedule,
                                  color: Colors.white70,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    write ? startTimePicker() : {};
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: starttimecontroller,
                                      decoration: InputDecoration(
                                          labelText: '시작시간선택',
                                          labelStyle:
                                              TextStyle(color: Colors.white70),
                                          filled: true,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white10),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      onSaved: (val) {
                                        startTIME = starttimecontroller.text;
                                        print(startTIME);
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return '입력해야합니다.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    !allDaySwitch && endTimeisSwitch
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.schedule,
                                  color: Colors.white70,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    write ? finishTimePicker() : {};
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      controller: finishtimecontroller,
                                      decoration: InputDecoration(
                                          labelText: '종료시간선택',
                                          filled: true,
                                          labelStyle:
                                              TextStyle(color: Colors.white70),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white10),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white))),
                                      onSaved: (val) {
                                        finishTIME = finishtimecontroller.text;
                                        print(startTIME);
                                      },
                                      validator: (val) {
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : new Container(),
                    SizedBox(
                      height: 20,
                    ),
                    write
                        ? Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ButtonTheme(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  submit();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WithFriend(
                                              id: id,
                                              calendarNUM: calendarNUM,
                                              scheduleDATE: scheduleDATE,
                                              scheduleTYPE: scheduleTYPE,
                                              scheduleDETAIL: scheduleDETAIL,
                                              scheduleLOCATION:
                                                  scheduleLOCATION,
                                              startTIME: startTIME,
                                              finishTIME: finishTIME,
                                              isWrite: write,
                                              userIDK: userIDK,
                                              localid: localid,
                                              hostNUM: hostNUM)));
                                },
                                icon: Icon(
                                  Icons.person_add_alt_1,
                                ),
                                label: Text(
                                  '함께하는 친구 설정하기',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          )
                        : new Container(),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  yearMonthDayPicker() async {
    final year = DateTime.now().year;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year),
      lastDate: DateTime(year + 10),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (dateTime != null) {
      datecontroller.text = dateTime.toString().split(' ')[0];
    }
  }

  startTimePicker() async {
    final year = DateTime.now().year;
    String hour, min;

    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (pickedTime != null) {
      hour = pickedTime.hour.toString();
      min = pickedTime.minute.toString();
      hour.length == 1 ? hour = '0' + hour : hour = hour;
      min.length == 1 ? min = '0' + min : min = min;

      starttimecontroller.text = '$hour:$min';
    }
  }

  finishTimePicker() async {
    final year = DateTime.now().year;
    String hour, min;

    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (pickedTime != null) {
      hour = pickedTime.hour.toString();
      min = pickedTime.minute.toString();
      hour.length == 1 ? hour = '0' + hour : hour = hour;
      min.length == 1 ? min = '0' + min : min = min;
      finishtimecontroller.text = '$hour:$min';
    }
  }

  submit() {
    setState(() => autovalidate = true);
    if (!_fKey.currentState.validate()) {
      return;
    }
    _fKey.currentState.save();
  }
}
