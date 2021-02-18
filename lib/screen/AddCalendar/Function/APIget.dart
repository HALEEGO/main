import 'dart:convert';

import 'package:calendar/data/Friend.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:http/http.dart';

String URL = "http://3.35.39.202:8000/calendar";

Future<List> searchFriend(id) async {
  print("api통신시작");
  Response response = await get("$URL/read/userfriend/$id");
  print("여기는 왔나요~?");
  print("${response.body}");
  List tmp = jsonDecode(response.body);
  print("우루룰ㄹ루루${tmp[0]}");
  Map<String, dynamic> temp = tmp[0];
  print(temp);
  print("꺄룰ㄹㄹ루루ㅜㄹ ${temp["userIDK"]}");
  for (int i = 0; i < response.body.length; i++) {}
  fuu = tmp;
  print("아잦ㅈ자자자ㅏㅈ$fuu");

  print("api통신끝");
  return fuu;
}
