class Calendar {
  int _calendarNUM;

  String _scheduleTYPE;

  String _scheduleDETAIL;

  String _scheduleDATE;

  String _startTIME;

  String _finishTIME;

  String _scheduleLOCATION;

  var _friendList = List<String>();
  int get getCalendarNUM => _calendarNUM;
  String get getScheduleTYPE => _scheduleTYPE;
  String get getScheduleDETAIL => _scheduleDETAIL;
  String get getScheduleDATE => _scheduleDATE;
  String get getStartTIME => _startTIME;
  String get getFinishTIME => _finishTIME;
  String get getScheduleLOCATION => _scheduleLOCATION;
  List get getFriendList => _friendList;

  set setCalendarNUM(int calendarNUM) => _calendarNUM = calendarNUM;
  set setScheduleTYPE(String scheduleTYPE) => _scheduleTYPE = scheduleTYPE;
  set setScheduleDETAIL(String scheduleDETAIL) =>
      _scheduleDETAIL = scheduleDETAIL;
  set setScheduleDATE(String scheduleDATE) => _scheduleDATE = scheduleDATE;
  set setStartTIME(String startTIME) => _startTIME = startTIME;
  set setFinishTIME(String finishTIME) => _finishTIME = finishTIME;
  set setScheduleLOCATION(String scheduleLOCATION) =>
      _scheduleLOCATION = scheduleLOCATION;
  void setFriendList(friend) {
    _friendList.add(friend);
  }

  Calendar(_calendarNUM, _scheduleTYPE, _scheduleDETAIL, _scheduleDATE,
      _startTIME, _finishTIME, _scheduleLOCATION, _friendList);
  void pALL() {
    print(_calendarNUM);
    print(_scheduleTYPE);
    print(_scheduleDETAIL);
    print(_scheduleDATE);
    print(_startTIME);
    print(_finishTIME);
    print(_scheduleLOCATION);
    print(_friendList.toString());
  }

  Calendar.fromJson(Map<String, dynamic> json)
      : _calendarNUM = json['calendarNUM'],
        _scheduleTYPE = json['scheduleTYPE'],
        _scheduleDETAIL = json['scheduleDETAIL'],
        _scheduleDATE = json['scheduleDATE'],
        _startTIME = json['startTIME'],
        _finishTIME = json['finishTIME'],
        _scheduleLOCATION = json['scheduleLOCATION'];

  Map<String, dynamic> toJson() => {
        '_scheduleTYPE': _scheduleTYPE,
        '_scheduleDETAIL': _scheduleDETAIL,
        '_scheduleDATE': _scheduleDATE,
        '_startTIME': _startTIME,
        '_finishTIME': _finishTIME,
        '_scheduleLOCATION': _scheduleLOCATION,
      };
}
