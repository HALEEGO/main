import 'dart:convert';

import 'package:http/http.dart';

var allEvents = Map<DateTime, List>(); //유저가 가진 모든 일정
var eventsOnlyME = Map<DateTime, List>(); //자기 혼자만 하는 일정
var eventsWithFriend = Map<DateTime, List>(); //여러명이서 같이하는 일정
List<dynamic> calendarList; //유저의 일정 리스트
List<dynamic> userList; //일정을 선택했을때  그 일정에 대한 친구 리스트
final String URL = "http://3.35.39.202:8000/calendar";
Future<String> searchcalendar(id) async {
  allEvents.clear();
  eventsOnlyME.clear();
  eventsWithFriend.clear();
  //futurebuilder 쓰기위해 future, http통신때매 async
  Response response = await get("$URL/read/usercalendar/$id"); //id에 대한 일정목록 받기
  calendarList =
      jsonDecode(response.body); //받은 일정목록(json데이터)(List<User>)를 calendar리스트에넣기
  for (int i = 0; i < calendarList.length; i++) {
    //일정을 돌아가며 지역변수에 넣기
    DateTime dt = DateTime.parse(
        "${calendarList[i]["scheduleDATE"]} 00:00:00.000"); //calendarList의 i번째인덱스의 key=scheduleDATE인값 + 00:00:00.000을 날짜화 시켜서 dt에 저장
    //날짜(key값)가 이미 들어가있으면 날짜(key)에 type,num(일정 기본키) <- (value)를 넣기

    if (allEvents.containsKey(dt)) {
      allEvents[dt].add(calendarList[i]["scheduleTYPE"]);
      allEvents[dt].add(calendarList[i]["calendarNUM"]);
    } else {
      //없으면 key,value하나 설정후 add   ///////   key값이 없는데 value를 add하면 오류발생
      allEvents[dt] = [
        calendarList[i]["scheduleTYPE"]
      ]; //따라서 처음값은 add가 아닌 직접 넣어주어야함
      allEvents[dt].add(calendarList[i]["calendarNUM"]);
    }

    Response res = //함께하는 사람 명수에 따라 혼자일정인지 여러명일정인지 분류
        await get(
            "$URL/read/calendaruser/${calendarList[i]["calendarNUM"]}"); //따라서 일정 하나가 가진 유저를 받아와야함
    userList = jsonDecode(res.body);
    if (userList.length == 1) {
      //함께하는 사람이 1(자기자신)이면 _eventOnlyMe리스트에 넣음
      if (eventsOnlyME.containsKey(dt)) {
        eventsOnlyME[dt].add(calendarList[i]["scheduleTYPE"]);
      } else {
        eventsOnlyME[dt] = [calendarList[i]["scheduleTYPE"]];
      }
    } else {
      //함께하는 사람이 여러명이면 _eventsWithFriend리스트에 넣음
      if (eventsWithFriend.containsKey(dt)) {
        eventsWithFriend[dt].add(calendarList[i]["scheduleTYPE"]);
      } else {
        eventsWithFriend[dt] = [calendarList[i]["scheduleTYPE"]];
      }
    }
  }
  return "abc"; //futurebuilder에 리턴값이 있어야해서 임시설정
}

Future<String> deletecalendar(calendarNUM) async {
  Response response = await delete("$URL/delete/calendar/$calendarNUM");

  return response.body.toString();
}
