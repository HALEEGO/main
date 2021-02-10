import 'package:calendar/screen/AddCalendar/addCalendar.dart';
import 'package:calendar/screen/Calendar/calendar.dart';
import 'package:flutter/material.dart';
import '../Home/home_screen.dart';

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.calendar_today_sharp),
        title: Text('~~의' + '\n' + 'SNS CALENDAR'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
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
              icon: Icon(Icons.person_pin_outlined),
              onPressed: () {
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
    HomeScreen(),
    Text(
      'Music',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Calendar(),
    Text(
      'News',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
    Text(
      'News',
      style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
    ),
  ];
}
