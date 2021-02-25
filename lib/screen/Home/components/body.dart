import 'dart:convert';

import 'package:calendar/screen/AddCalendar/addCalendar.dart';
import 'package:calendar/screen/Home/components/planFunction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'background.dart';
import '../../../data/Calendar.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final String id;
  Body({this.id});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var todaystamp = DateTime.now().day;
  var monthstamp = DateTime.now().month;
  var yearstamp = DateTime.now().year;
  var now = DateTime.now();
  String nowstamp = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String id;
  String URL = "http://3.35.39.202:8000/calendar";

  Future<List<Calendar>> fetchCalendar(String id, String date) async {
    final response = await get("$URL/read/usercalendardate/${widget.id}/$date");
    if (response.statusCode == 200) {
      var responseJson = (json.decode(response.body));
      return (responseJson as List).map((e) => Calendar.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load todayCalendar");
    }
  }

  Future<List<Calendar>> fetchedCalendar;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    fetchedCalendar = fetchCalendar(id, nowstamp);
    // CalendarInfo(id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Background(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: size.width * 0.95,
              height: size.height * 0.35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.4),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 15),
                    width: size.width * 0.95,
                    height: size.height * 0.07,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 0.3)),
                    ),
                    child: Text(
                      "오늘의 TODO",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Container(
                          decoration: BoxDecoration(),
                          child: FutureBuilder<List<Calendar>>(
                            future: fetchedCalendar,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data.length == 0
                                    ? Text("일정이 없네요 ^^7",
                                        style: TextStyle(color: Colors.white))
                                    : ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          if (snapshot.data[i].getFinishTIME ==
                                              null) {
                                            if (snapshot.data[i].getStartTIME ==
                                                null) {
                                              return ListTile(
                                                title: Text("하루종일",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                trailing: Text(
                                                    snapshot.data[i]
                                                        .getScheduleTYPE,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              );
                                            } else {
                                              return ListTile(
                                                title: Text(
                                                    "${snapshot.data[i].getStartTIME}",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                trailing: Text(
                                                    snapshot.data[i]
                                                        .getScheduleTYPE,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              );
                                            }
                                          } else {
                                            return ListTile(
                                              title: Text(
                                                  "${snapshot.data[i].getStartTIME}~${snapshot.data[i].getFinishTIME}",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              trailing: Text(
                                                  snapshot
                                                      .data[i].getScheduleTYPE,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            );
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int i) {
                                          return const Divider();
                                        },
                                      );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.95,
              height: size.height * 0.07,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15, top: 10),
              // decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.black)),
              child: Text(
                "일정",
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
            Container(
                height: size.height * 0.35,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        width: size.width * 0.7,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.3, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              alignment: Alignment.center,
                              width: size.width * 0.7,
                              height: size.height * 0.05,
                              child: Text(
                                "${now.add(new Duration(days: index)).toString().split("-")[1]}월 ${now.add(new Duration(days: index)).toString().split("-")[2].split(" ")[0]}일",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                            FutureBuilder<List<Calendar>>(
                                future: fivecalendar(
                                    id,
                                    now
                                        .add(new Duration(days: index))
                                        .toString()
                                        .split(" ")[0]),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height: size.height * 0.25,
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: snapshot.data.length == 0
                                              ? 1
                                              : snapshot.data.length,
                                          itemBuilder: (context, int index2) {
                                            if (snapshot.data.length == 0) {
                                              return ListTile(
                                                title: Text(
                                                  "일정이없습니다",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                trailing: Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  color: Colors.red[400],
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => AddCalendar(
                                                              title: "일정 추가하기",
                                                              id: id,
                                                              scheduleDATE: now
                                                                  .add(new Duration(
                                                                      days:
                                                                          index))
                                                                  .toString()
                                                                  .split(
                                                                      " ")[0])));
                                                },
                                              );
                                            } else {
                                              return ListTile(
                                                title: Text(
                                                  "${snapshot.data[index2].getScheduleTYPE}",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddCalendar(
                                                                title: "일정",
                                                                id: id,
                                                                calendarNUM: snapshot
                                                                    .data[
                                                                        index2]
                                                                    .getCalendarNUM
                                                                    .toString()),
                                                      ));
                                                },
                                              );
                                            }
                                          }),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ],
                        ),
                      );
                    })),
          ],
        ),
      ),
    ]);
  }
}
