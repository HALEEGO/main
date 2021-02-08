import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('플러터 캘린더'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              rowHeight: 100,
              locale: 'ko_KO',
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: Colors.orange,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white),
              ),
              builders: CalendarBuilders(
                todayDayBuilder: (context, date, events) => Container(
                  child: Text(date.day.toString()),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  alignment: Alignment.topCenter,
                ),
                selectedDayBuilder: (context, date, events) => Container(
                  child: Text(date.day.toString()),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  alignment: Alignment.topCenter,
                ),
                dayBuilder: (context, date, events) => Container(
                    alignment: Alignment.topCenter,
                    child: Text(date.day.toString())),
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }
}
