import '../../data/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddCalendar extends StatefulWidget {
  @override
  _AddCalendarState createState() => _AddCalendarState();
}

class _AddCalendarState extends State<AddCalendar> {
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  bool autovalidate = false;
  String scheduleTYPE,
      scheduleDETAIL,
      scheduleDATE,
      startTIME,
      finishTIME,
      scheduleLOCATION;

  Calendar calendar = Calendar(
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  );
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
          '새로운 이벤트',
        ),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: Form(
        key: _fKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            TextFormField(
                maxLength: 20,
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
                onChanged: (text) => scheduleTYPE = text),
            TextFormField(
                maxLength: 20,
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
                onChanged: (text) => scheduleDETAIL = text),
            TextFormField(
                maxLength: 20,
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
                onChanged: (text) => scheduleLOCATION = text),
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
              onTap: () {}, //친구 선택하는 페이지로 라우트
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
      ),
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

      starttimecontroller.text = '$hour' + '시' + ' ' + '$min' + '분';
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

      finishtimecontroller.text = '$hour' + '시' + ' ' + '$min' + '분';
    }
  }

  submit() {
    setState(() => autovalidate = true);

    if (!_fKey.currentState.validate()) {
      return;
    }

    _fKey.currentState.save();
    calendar.setScheduleTYPE = scheduleTYPE;
    calendar.setScheduleDETAIL = scheduleDETAIL;
    calendar.setScheduleDATE = scheduleDATE;
    calendar.setStartTIME = startTIME;
    calendar.setFinishTIME = finishTIME;
    calendar.setScheduleLOCATION = scheduleLOCATION;

    calendar.pALL();
  }
}
