import 'dart:convert';

import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:http/http.dart';

String URL = "http://3.35.39.202:8000/calendar";

Future<List> searchFriend(id) async {
  Response response = await get("$URL/read/userfriend/$id");
  List tmp = jsonDecode(response.body);
  for (int i = 0; i < response.body.length; i++) {}
  fuu = tmp;
  return fuu;
}

Future<List> nochangedsearchFriend(id) async {
  Response response = await get("$URL/read/calendaruser/$id");
  List tmp = jsonDecode(response.body);
  for (int i = 0; i < response.body.length; i++) {}
  fuu = tmp;
  print("api통신끝");
  return fuu;
}
