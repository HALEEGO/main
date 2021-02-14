import 'package:calendar/constants.dart';
import 'package:calendar/screen/AddCalendar/addCalendar.dart';
import 'package:calendar/screen/Calendar/calendar.dart';
import 'package:calendar/screen/Friend/Friend_screen.dart';
import 'package:calendar/screen/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  @override
  void initState() {
    super.initState();
    id = widget.id;
    print(id);
    firstPage();
    secondPage(); // first페이지로 id전달
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.calendar_today_sharp,
          color: kPrimaryColor,
        ),
        title: Text(
          '${widget.id}의' + '\n' + 'SNS CALENDAR',
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddCalendar();
                  },
                ),
              );
            },
          ),
          IconButton(
              icon: Icon(
                Icons.person_pin_outlined,
                color: kPrimaryColor,
              ),
              onPressed: () {
                storage.delete(key: "login");
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => WelcomeScreen()),
                );
                //내정보 확인할 수 있는 페이지로
              }),
          Padding(padding: EdgeInsets.only(left: 10)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
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
          BottomNavigationBarItem(
            title: Text('ALARM'),
            icon: Icon(Icons.alarm),
          ),
          BottomNavigationBarItem(
            title: Text('SETTING'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  List _widgetOptions = [
    //여기에 페이지 넣으면됨
    null,
    null,
    Calendar(),
    Text(
      'News',
      style: TextStyle(
        fontSize: 30,
      ),
    ),
    Text(
      'News',
      style: TextStyle(
        fontSize: 30,
      ),
    ),
  ];
  void firstPage() {
    _widgetOptions[0] = HomeScreen(
      id: id,
    );
  }

  void secondPage() {
    _widgetOptions[1] = Friendscreen(id: id);
  }
}
