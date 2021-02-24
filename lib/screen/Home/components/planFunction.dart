import 'dart:convert';

import 'package:calendar/data/Calendar.dart';
import 'package:http/http.dart';

Future<List<Calendar>> fivecalendar(String id, String date) async {
  print("date : $date");
  String URL = "http://3.35.39.202:8000/calendar";
  Response response =
      await get("$URL/read/usercalendardate/$id/$date"); // List<calendar>
  print("여기?");
  var tmp = jsonDecode(response.body);

  return (tmp as List).map((e) => Calendar.fromJson(e)).toList();
}
