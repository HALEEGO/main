import 'dart:convert';

import 'package:calendar/components/ok_notice.dart';
import 'package:calendar/constants.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/AddCalendar/addCalendar.dart';
import 'package:calendar/screen/Calendar/calendar.dart';
import 'package:calendar/screen/Friend/Friend_screen.dart';
import 'package:calendar/screen/Home/screen/changename.dart';
import 'package:calendar/screen/Home/screen/userInfo_screen.dart';
import 'package:calendar/screen/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../Home/home_screen.dart';

class MainBody extends StatefulWidget {
  final String id;
  MainBody({this.id});

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  static final storage = FlutterSecureStorage();
  String userInfo;
  String id = '';
  User user = User(null, null, null, null, null);
  @override
  void initState() {
    super.initState();
    id = widget.id;
    print(id);
    firstPage();
    secondPage();
    thirdPage(); // first페이지로 id전달
  }

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("앱을 종료하시겠습니까?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("NO"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context, true),
                )
              ],
            ));
  }

  Future<String> getNameApi(id) async {
    Response response =
        await get("http://3.35.39.202:8000/calendar/read/user/$id");
    var userInfo = jsonDecode(response.body);
    print("object");
    return userInfo["userNAME"];
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNameApi(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WillPopScope(
              onWillPop: _onbackpressed,
              child: Scaffold(
                appBar: (_selectedIndex == 1)
                    ? AppBar(
                        backgroundColor: Colors.white10,
                        leading: Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.white70,
                        ),
                        title: Text(
                          '${snapshot.data}' + '\n' + '친구보깅 ^^',
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.person_add_alt_1,
                              color: Colors.red[400],
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Ok(
                                    titleText: 'test',
                                    bodyText: 'please',
                                  );
                                },
                              );
                              //
                            },
                          ),
                        ],
                      )
                    : AppBar(
                        backgroundColor: Colors.white10,
                        leading: Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.white70,
                        ),
                        title: Text(
                          '${snapshot.data}의' + '\n' + 'SNS CALENDAR',
                          style: TextStyle(color: Colors.white70),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.red[400],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddCalendar(
                                      title: "일정 추가하기",
                                      id: id,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.person_pin_outlined,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserInfo(id: id)));
                                //내정보 확인할 수 있는 페이지로
                              }),
                          Padding(padding: EdgeInsets.only(left: 10)),
                        ],
                      ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white10,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white38,
                  selectedFontSize: 14,
                  unselectedFontSize: 10,
                  currentIndex: _selectedIndex, //현재 선택된 Index
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      title: Text('HOME'),
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      title: Text('FRIEND'),
                      icon: Icon(Icons.people),
                    ),
                    BottomNavigationBarItem(
                      title: Text('CALENDAR'),
                      icon: Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                body: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            );
          } else {
            return new Container();
          }
        });
  }

  List _widgetOptions = [
    //여기에 페이지 넣으면됨
    null,
    null,
    null,
  ];
  void firstPage() {
    _widgetOptions[0] = HomeScreen(
      id: id,
    );
  }

  void secondPage() {
    _widgetOptions[1] = Friendscreen(id: id);
  }

  void thirdPage() {
    _widgetOptions[2] = Calendar(title: id);
  }
}
