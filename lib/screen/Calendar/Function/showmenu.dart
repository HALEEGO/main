import 'dart:ui';

import 'package:calendar/screen/AddCalendar/addCalendar.dart';
import 'package:calendar/screen/Calendar/Function/APIget.dart';
import 'package:calendar/screen/Main/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutter_swipe_action_cell/core/controller.dart';
import 'package:path/path.dart';

void showmenu(DateTime day, Map<DateTime, List> _allEvents,
    BuildContext context, _animationController, id, swipecontroller) {
  void showAlertDialog(BuildContext context, i) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('일정 삭제'),
          content: Text("이 일정을 삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.pop(context, "NO");
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                deletecalendar(
                    "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i + 1]}");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Mainmenu(id: id)),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  //날짜 클릭하면 뜨는 메뉴
  bool haveEvent = _allEvents.containsKey(DateTime.parse(day
      .toString()
      .replaceAll("12", "00")
      .replaceAll("Z", ""))); //왜인지는 모르겠는데 파라미터형태가 ****-**-** 12:00:00.000Z으로옴
  //문자열로 바꾸기 > 12를 00으로, Z없애기 > 다시 datetime형태로 바꾸기 > _allevent에 그날짜의 이벤트가 있는지 확인 ? true : false
  int eventCount;
  if (haveEvent) {
    //이벤트가 있으면
    eventCount = _allEvents[DateTime.parse(
            day.toString().replaceAll("12", "00").replaceAll("Z", ""))]
        .length; //그 길이만큼 eventCount 설정
  } else {
    eventCount = 0; //없으면 0
  } //null값은 length를 못써서 따로 설정해줘야함

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(65, 65, 65, 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 40,
                color: Color.fromRGBO(65, 65, 65, 1),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "${day.toString().split("-")[1]}월  ${day.toString().split("-")[2].split(" ")[0]}일 ",
                  style: TextStyle(
                    color: Color.fromRGBO(147, 147, 147, 1),
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                  height:
                      MediaQuery.of(context).size.height * 0.485, //안쪽 컨테이너 높이
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          color: Color.fromRGBO(65, 65, 65, 1)),
                      child: Stack(
                        alignment: Alignment(0, 0),
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Positioned(
                            child: GestureDetector(
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: eventCount, //일정의 갯수
                                  itemBuilder: (BuildContext context, int i) {
                                    //_allEvents에 일정PK도 넣어놔서 홀수번째 index에는 listtile을 만들면안됨

                                    if (i % 2 != 0) {
                                      return SizedBox();
                                    } else {
                                      // 0,짝수번째 index만 listTile만들기
                                      return SwipeActionCell(
                                          backgroundColor:
                                              Color.fromRGBO(65, 65, 65, 1),
                                          key: ValueKey(i),
                                          index: i,
                                          controller: swipecontroller,
                                          performsFirstActionWithFullSwipe:
                                              true,
                                          trailingActions: [
                                            SwipeAction(
                                                title: "삭제",
                                                nestedAction: SwipeNestedAction(
                                                    title: "삭제하기"),
                                                onTap: (handler) async {
                                                  showAlertDialog(context, i);
                                                }),
                                            SwipeAction(
                                              title: "일정",
                                              color: Colors.grey,
                                              onTap: (handler) async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            // print("object");
                                                            AddCalendar(
                                                              title:
                                                                  "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i]}",
                                                              calendarNUM:
                                                                  "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i + 1]}",
                                                              id: id,
                                                            )));
                                              },
                                            )
                                          ],
                                          child: ListTile(
                                            leading: Icon(
                                              Icons.calendar_today_outlined,
                                              color: Color.fromRGBO(
                                                  147, 147, 147, 1),
                                            ),
                                            title: Text(
                                              //이벤트 짝수 인덱스만 출력
                                              "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i]}",
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color.fromRGBO(
                                                  147, 147, 147, 1),
                                            ),
                                            onTap: () {
                                              // print("object");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          // print("object");
                                                          AddCalendar(
                                                            title:
                                                                "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i]}",
                                                            calendarNUM:
                                                                "${_allEvents[DateTime.parse(day.toString().replaceAll("12", "00").replaceAll("Z", ""))][i + 1]}",
                                                            id: id,
                                                          )));
                                            },
                                          ));
                                    }
                                  }),
                            ),
                          )
                        ],
                      ))),
            ],
          ),
        );
      });
}
