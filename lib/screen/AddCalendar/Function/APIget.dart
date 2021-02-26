import 'dart:convert';

import 'package:calendar/screen/AddCalendar/Function/withFriend.dart';
import 'package:http/http.dart';

String URL = "http://3.35.39.202:8000/calendar";

Future<List> searchFriend(id, calnum) async {
  Response response = await get("$URL/read/userfriend/$id");
  List ttemp = jsonDecode(response.body);
  fuu.clear();
  fuu = ttemp;
  if (calnum == null) {
  } else {
    Response re = await get("$URL/read/calendaruser/$calnum");
    fuuu = jsonDecode(re.body);
  }
  print("fuu ::::::::::::::::::::::::::::: $fuu");
  print("fuuu 는 :::::::::::::::::::::::::::::::$fuuu");
  return fuu;
}

Future<List> nochangedsearchFriend(calnum, id) async {
  Response response = await get("$URL/read/calendaruser/$calnum");
  List tmp = jsonDecode(response.body);
  fuu = tmp;
  Response re = await get("$URL/read/calendaruser/$calnum");
  fuuu = jsonDecode(re.body);
  print("fuu ::::::::::::::::::::::::::::: $fuu");
  return fuu;
}
