import 'package:calendar/data/Calendar.dart';
import 'package:calendar/data/User.dart';

class Calendar_has_User {
  List<User> _calendarHasUserList; // 일정이 가지고있는 유저 리스트
  List<Calendar> _userHasCalendarList; // 유저가 가지고있는 일정 리스트

  List<User> get getCalendarHasUserList => _calendarHasUserList;
  List<Calendar> get getUserHasCalendarList => _userHasCalendarList;

  //세터 대신 리스트라 add로 처리했음
  //세터와 같은역할
  //하지만 list 넣을때 반복문(foreach or list size만큼for문반복)
  //으로 넣어줘야할것같음
  void addCalendarHasUserList(User user) {
    _calendarHasUserList.add(user);
  }

  void addUserHasCalendarList(Calendar calendar) {
    _userHasCalendarList.add(calendar);
  }
}
