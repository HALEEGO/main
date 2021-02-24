import 'dart:convert';

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
  String nowstamp = DateFormat('yyyy-mm-dd').format(DateTime.now());

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
                                          return ListTile(
                                            leading: Text(
                                                snapshot.data[i].getStartTIME,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            title: Text(
                                                snapshot.data[i].getFinishTIME,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            trailing: Text(
                                                snapshot
                                                    .data[i].getScheduleTYPE,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          );
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
                  itemBuilder: (context, int indexx) {
                    return new Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: size.width * 0.7,
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 200,
                          height: 30,
                          alignment: Alignment.topLeft,
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.3)),
                          child: Text("$monthstamp월 ${todaystamp + indexx}일",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.ac_unit),
                                    title: Text("data"),
                                    trailing: Icon(Icons.ac_unit_outlined),
                                  );
                                }))
                      ]),
                    ); // 여기임
                  }),
            ) //realcon
          ],
        ),
      ),
    ]);
  }
}
