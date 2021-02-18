import 'dart:convert';

import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:http/http.dart';

import '../../data/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddCalendar extends StatefulWidget {
  final String title;
  final String calendarNUM;
  final String id;
  AddCalendar({@required this.title, this.calendarNUM, @required this.id});

  @override
  _AddCalendarState createState() => _AddCalendarState();
}

class _AddCalendarState extends State<AddCalendar> {
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  bool autovalidate = false;
  String id;
  String title;
  String calendarNUM;
  String scheduleTYPE,
      scheduleDETAIL,
      scheduleDATE,
      startTIME,
      finishTIME,
      scheduleLOCATION;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    if (widget.calendarNUM != null) {
      calendarNUM = widget.calendarNUM;
    }
    id = widget.id;
    calendar.setFriendList(id);
  }

  final String URL = "http://3.35.39.202:8000/calendar";
  Future<String> api() async {
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
      return "a";
    } else {
      return "d";
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
        title: Text(
          '$title',
        ),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: FutureBuilder(
          future: api(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _fKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    TextFormField(
                      maxLength: 20,
                      controller: scheduleTYPEcontroller,
                      decoration: InputDecoration(
                        labelText: '일정제목',
                        labelStyle: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                        icon: Icon(
                          Icons.title,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[900]),
                        ),
                      ),
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
                      controller: scheduleDETAILcontroller,
                      decoration: InputDecoration(
                        labelText: '일정내용',
                        labelStyle: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                        icon: Icon(
                          Icons.title,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[900]),
                        ),
                      ),
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
                      maxLength: 20,
                      controller: scheduleLOCATIONcontroller,
                      decoration: InputDecoration(
                        labelText: '위치',
                        labelStyle: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                        icon: Icon(
                          Icons.title,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[900]),
                        ),
                      ),
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
                      leading: Icon(Icons.timer),
                      title: Text(
                        '하루종일',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                      ),
                      trailing: Switch(
                        value: allDaySwitch,
                        onChanged: (value) {
                          setState(() {
                            allDaySwitch = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.timer),
                      title: Text(
                        '종료시간 설정하기',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                      ),
                      trailing: Switch(
                        value: endTimeisSwitch,
                        onChanged: (value) {
                          setState(() {
                            endTimeisSwitch = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.schedule,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: GestureDetector(
                            onTap: yearMonthDayPicker,
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: datecontroller,
                                decoration: InputDecoration(
                                  labelText: '날짜선택',
                                  filled: true,
                                ),
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
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: GestureDetector(
                                  onTap: startTimePicker,
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: starttimecontroller,
                                      decoration: InputDecoration(
                                        labelText: '시작시간선택',
                                        filled: true,
                                      ),
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
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: GestureDetector(
                                  onTap: finishTimePicker,
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: finishtimecontroller,
                                      decoration: InputDecoration(
                                        labelText: '종료시간선택',
                                        filled: true,
                                      ),
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
                    ListTile(
                      leading: Icon(Icons.accessibility_new),
                      title: Text(
                        '함께하는사람 설정하기',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WithFriend(id: id)));
                      }, //친구 선택하는 페이지로 라우트
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ButtonTheme(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                ),
                                label: Text('취소하기'),
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: ButtonTheme(
                              child: OutlinedButton.icon(
                                onPressed: () => submit(),
                                icon: Icon(
                                  Icons.save,
                                ),
                                label: Text('저장하기'),
                              ),
                            ),
                          )
                        ])
                  ],
                ),
              );
            } else {
              return Container();
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
    calendar.setCalendarNUM = int.parse(calendarNUM);
    calendar.setScheduleTYPE = scheduleTYPE;
    calendar.setScheduleDETAIL = scheduleDETAIL;
    calendar.setScheduleDATE = scheduleDATE;
    calendar.setStartTIME = startTIME;
    calendar.setFinishTIME = finishTIME;
    calendar.setScheduleLOCATION = scheduleLOCATION;

    calendar.pALL();
  }
}
