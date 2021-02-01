import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../data/data.dart';

class PushPlan extends StatefulWidget {
  final String title = '제목';

  @override
  _PushPlanState createState() => _PushPlanState();
}

class _PushPlanState extends State<PushPlan> {
  GlobalKey<FormState> _fKey = GlobalKey<FormState>();
  String planName, located;
  String yearMonthDayTime, yearMonthDayTime1, yearMonthDay;
  TextEditingController ymdController = TextEditingController();
  TextEditingController ymdtController = TextEditingController();
  TextEditingController ymdtController1 = TextEditingController();
  final planNameController = TextEditingController();
  final locatedController = TextEditingController();

  bool allDaySwitched = false; //하루종일,알람 스위치버튼
  bool alramisSwitched = false;
  bool endTimeisSwitched = true; // 알림받기 스위치버튼

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
      body: Scrollbar(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: planNameController,
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: locatedController,
                        onSaved: (val) {
                          located = locatedController.text;
                        },
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: '위치',
                          labelStyle: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 12,
                          ),
                          icon: Icon(
                            Icons.near_me,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[900]),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                  ],
                )
              ],
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
                value: allDaySwitched,
                onChanged: (value) {
                  setState(() {
                    allDaySwitched = value;
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
                value: endTimeisSwitched,
                onChanged: (value) {
                  setState(() {
                    endTimeisSwitched = value;
                  });
                },
              ),
            ),
            !allDaySwitched
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
                          onTap: yearMonthDayTimePicker,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: ymdtController,
                              decoration: InputDecoration(
                                labelText: '시작시간',
                                filled: true,
                              ),
                              onSaved: (val) {
                                yearMonthDayTime = ymdtController.text;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Year-Month-Date-Time is necessary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )
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
                          onTap: yearMonthDayPicker,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: ymdController,
                              decoration: InputDecoration(
                                labelText: '날짜선택',
                                filled: true,
                              ),
                              onSaved: (val) {
                                yearMonthDayTime = ymdController.text;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Year-Month-Date is necessary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

            SizedBox(height: 5.0),
            !allDaySwitched && endTimeisSwitched
                ? Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.history_toggle_off,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: GestureDetector(
                          onTap: yearMonthDayTimePicker1,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: ymdtController1,
                              decoration: InputDecoration(
                                labelText: '종료시간',
                                filled: true,
                              ),
                              onSaved: (val) {
                                yearMonthDayTime1 = ymdtController1.text;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Year-Month-Date-Time is necessary';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : new Container(),

            SizedBox(height: 40.0),
            ListTile(
              leading: Icon(Icons.campaign),
              title: Text(
                '알림받기',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 12,
                ),
              ),
              trailing: Switch(
                value: alramisSwitched,
                onChanged: (value) {
                  setState(() {
                    alramisSwitched = value;
                  });
                },
              ),
            ),
            SizedBox(height: 40.0),
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

            //여기부터 가장하단 버튼 (저장,취소)
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
                    child: ButtonTheme(
                  buttonColor: Colors.red,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      if (allDaySwitched) {
                        PlanInfo pi = PlanInfo();
                        pi.setPlanName = planNameController.text;
                        pi.Setlocated = locatedController.text;
                        pi.SetallDaySwitched = allDaySwitched;
                        pi.SetendTimeisSwitched = endTimeisSwitched;
                        pi.SetalramisSwitched = alramisSwitched;
                        pi.Settime = ymdController.text;
                        pi.prtall();
                      } else if (endTimeisSwitched) {
                        PlanInfo pi = PlanInfo();
                        pi.setPlanName = planNameController.text;
                        pi.Setlocated = locatedController.text;
                        pi.SetallDaySwitched = allDaySwitched;
                        pi.SetendTimeisSwitched = endTimeisSwitched;
                        pi.SetalramisSwitched = alramisSwitched;
                        pi.Setstarttime = ymdtController.text;
                        pi.Setendtime = ymdtController1.text;
                        pi.prtall();
                      } else {
                        PlanInfo pi = PlanInfo();
                        pi.setPlanName = planNameController.text;
                        pi.Setlocated = locatedController.text;
                        pi.SetallDaySwitched = allDaySwitched;
                        pi.SetendTimeisSwitched = endTimeisSwitched;
                        pi.SetalramisSwitched = alramisSwitched;
                        pi.Setstarttime = ymdtController.text;
                        pi.Setendtime = ymdtController1.text;
                        pi.prtall();
                      }
                    },
                    icon: Icon(
                      Icons.save,
                    ),
                    label: Text('저장하기'),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  yearMonthDayTimePicker() async {
    final year = DateTime.now().year;
    String hour, min;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year - 10),
      lastDate: DateTime(year + 10),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (dateTime != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }

        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }

        ymdtController.text = '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
  }

  yearMonthDayTimePicker1() async {
    final year = DateTime.now().year;
    String hour, min;

    final DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(year - 10),
      lastDate: DateTime(year + 10),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (dateTime != null) {
      final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null) {
        if (pickedTime.hour < 10) {
          hour = '0' + pickedTime.hour.toString();
        } else {
          hour = pickedTime.hour.toString();
        }

        if (pickedTime.minute < 10) {
          min = '0' + pickedTime.minute.toString();
        } else {
          min = pickedTime.minute.toString();
        }

        ymdtController1.text =
            '${dateTime.toString().split(' ')[0]} $hour:$min';
      }
    }
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
      ymdController.text = dateTime.toString().split(' ')[0];
    }
  }
}
