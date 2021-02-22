import 'dart:convert';

import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:http/http.dart';

String URL = "http://3.35.39.202:8000/calendar";

Future<List> searchFriend(id, calnum) async {
  Response response = await get("$URL/read/userfriend/$id");
  List tmp = jsonDecode(response.body);
  fuu = tmp;
  Response res = await get("$URL/read/calendaruser/$calnum");
  List temp = jsonDecode(response.body);
  Response re = await get("$URL/read/user/$id");
  userIDK = jsonDecode(re.body)["userIDK"];
  fuuu = tmp;
  return fuu;
}

Future<List> nochangedsearchFriend(calnum, id) async {
  Response response = await get("$URL/read/calendaruser/$calnum");
  List tmp = jsonDecode(response.body);
  fuu = tmp;
  Response res = await get("$URL/read/user/$id");
  userIDK = jsonDecode(res.body)["userIDK"];
  print("${res.body}");
  print("api통신끝");
  return fuu;
}
