import 'package:calendar/screen/Calendar/Function/showmenu.dart';
import 'package:calendar/screen/Calendar/tablecalendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:table_calendar/table_calendar.dart';
import './Function/APIget.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  String id; //user의 id
  AnimationController _animationController;
  CalendarController _calendarController;
  SwipeActionController swipecontroller;

  @override
  void initState() {
    super.initState();
    id = widget.title; //id 지역변수로 넣기
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    swipecontroller = SwipeActionController(selectedIndexPathsChangeCallback:
        (changedIndexPaths, selected, currentCount) {
      setState(() {});
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

//////////////////////////////////////메인 빌드////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FutureBuilder(
              future: searchcalendar(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildTableCalendarWithBuilders(_calendarController,
                      _animationController, context, id, swipecontroller);
                } else {
                  return Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ));
                }
              },
            )
          ],
        ),
      ),
    ));
  }

////////////////////////////////////////메인 빌드/////////////////////////////////////////////

}
