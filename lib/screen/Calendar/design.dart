import 'package:flutter/material.dart';

Widget selectedDayBuildertoday(date) {
  return Container(
    alignment: Alignment.center,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle(color: Colors.white).copyWith(fontSize: 16.0),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        color: Colors.redAccent),
  );
}

Widget todayDayBuilder(date) {
  return Container(
    alignment: Alignment.center,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle(color: Colors.white).copyWith(fontSize: 16.0),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        color: Colors.redAccent),
  );
}

Widget dayBuilder(date) {
  return Container(
    padding: const EdgeInsets.only(top: 5),
    alignment: Alignment.topCenter,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle().copyWith(fontSize: 16.0),
    ),
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey[900], width: 0.2))),
  );
}

Widget weekendDayBuilder(date) {
  return Container(
    padding: const EdgeInsets.only(top: 5),
    alignment: Alignment.topCenter,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle().copyWith(
        fontSize: 16.0,
        color: Colors.red,
      ),
    ),
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey[900], width: 0.2))),
  );
}

Widget outsideDayBuilder(date) {
  return Container(
    padding: const EdgeInsets.only(top: 5),
    alignment: Alignment.topCenter,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle().copyWith(
        fontSize: 16.0,
        color: Colors.black38,
      ),
    ),
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey[900], width: 0.2))),
  );
}

Widget outsideWeekendDayBuilder(date) {
  return Container(
    padding: const EdgeInsets.only(top: 5),
    alignment: Alignment.topCenter,
    width: 100,
    height: 100,
    child: Text(
      '${date.day}',
      style: TextStyle().copyWith(
        fontSize: 16.0,
        color: Colors.red[100],
      ),
    ),
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Colors.grey[900], width: 0.2))),
  );
}

Widget buildEventsMarker(DateTime date, List events) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.cyan[50]),
    width: 20.0,
    height: 20.0,
    child: Center(
      child: Text(
        '${events.length}',
        style: TextStyle().copyWith(
          color: Colors.cyan[900],
          fontSize: 12.0,
        ),
      ),
    ),
  );
}

Widget buildHolidaysMarker(DateTime date, List holiday) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue[400],
    ),
    width: 20.0,
    height: 20.0,
    child: Center(
      child: Text(
        '${holiday.length}',
        style: TextStyle().copyWith(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    ),
  );
}
