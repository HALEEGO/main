import 'dart:ui';

import 'package:calendar/screen/Calendar/Function/showmenu.dart';
import 'package:calendar/screen/Calendar/design.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import './Function/APIget.dart';

void _onDaySelected(
  DateTime day,
  List events,
  List holidays,
  context,
  _animationController,
) {
  //선택되는날 함수
  print('CALLBACK: _onDaySelected');
  showmenu(
    day,
    allEvents,
    context,
    _animationController,
  );
}

void _onVisibleDaysChanged(
    //달 이동하면 호출됨
    DateTime first,
    DateTime last,
    CalendarFormat format) {
  print('CALLBACK: _onVisibleDaysChanged');
}

void _onCalendarCreated(
    //제일처음 달력 만들어질때 호출됨
    DateTime first,
    DateTime last,
    CalendarFormat format) {
  print('CALLBACK: _onCalendarCreated');
}

Widget buildTableCalendarWithBuilders(
  _calendarController,
  _animationController,
  context,
) {
  return TableCalendar(
    rowHeight: 70, //날짜 높이
    locale: 'ko_KO', //언어
    calendarController: _calendarController,
    events: eventsOnlyME,
    holidays: eventsWithFriend,
    initialCalendarFormat: CalendarFormat.month, //month로 보이게
    formatAnimation: FormatAnimation.slide, //좌우로 슬라이드해서 month변경
    startingDayOfWeek: StartingDayOfWeek.sunday, //달력 시작날짜를 일요일로
    availableGestures: AvailableGestures.all,
    availableCalendarFormats: const {
      CalendarFormat.month: '', //month만 넣어서 twoeweek, week로 안바뀌게
    },
    calendarStyle: CalendarStyle(
      outsideDaysVisible: true,
      weekendStyle: TextStyle().copyWith(color: Colors.red), //
      holidayStyle: TextStyle().copyWith(color: Colors.yellow), // 이거두갠 뭔지모르겠음
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      weekendStyle: TextStyle().copyWith(color: Colors.red),
    ),
    headerStyle: HeaderStyle(
      centerHeaderTitle: true, //년 , 월 중간에
      formatButtonVisible: false, //병찬이가 좋아하던 버튼 없앰
    ),
    builders: CalendarBuilders(
      selectedDayBuilder: (context, date, _) {
        if (_calendarController.isToday(date)) {
          //선택된 날짜가 오늘이면 원래 오늘 모양
          return selectedDayBuildertoday(date);
        } else {
          //선택된 날짜가 오늘이아니면
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0)
                .animate(_animationController), //애니메이터 //투명도 0~1로 움직이는듯
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.topCenter,
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        }
      },
      todayDayBuilder: (context, date, _) {
        //오늘날짜 디자인
        return todayDayBuilder(date);
      },
      dayBuilder: (context, date, _) {
        //날짜 디자인
        return dayBuilder(date);
      },
      weekendDayBuilder: (context, date, _) {
        //주말 디자인
        return weekendDayBuilder(date);
      },
      outsideDayBuilder: (context, date, _) {
        //이번달 밖 평일 디자인
        return outsideDayBuilder(date); //design.dart
      },
      outsideWeekendDayBuilder: (context, date, _) {
        return outsideWeekendDayBuilder(date);
      },
      markersBuilder: (context, date, events, holidays) {
        final children = <Widget>[];

        if (events.isNotEmpty) {
          children.add(
            Positioned(
              right: 5,
              bottom: 5,
              child: buildEventsMarker(date, events),
            ),
          );
        }

        if (holidays.isNotEmpty) {
          children.add(
            Positioned(
              left: 5,
              bottom: 5,
              child: buildHolidaysMarker(date, holidays),
            ),
          );
        }

        return children;
      },
    ),
    onDaySelected: (date, events, holidays) {
      _onDaySelected(date, events, holidays, context, _animationController);
      _animationController.forward(from: 0.0);
    },
    onVisibleDaysChanged: _onVisibleDaysChanged,
    onCalendarCreated: _onCalendarCreated,
  );
}
