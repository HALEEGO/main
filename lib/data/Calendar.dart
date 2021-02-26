class Calendar {
  int _calendarNUM;

  String _scheduleTYPE;

  String _scheduleDETAIL;

  String _scheduleDATE;

  String _startTIME;

  String _finishTIME;

  String _scheduleLOCATION;

  int _hostNUM;

  var _friendLIST = List<String>();

  int get getCalendarNUM => _calendarNUM;
  String get getScheduleTYPE => _scheduleTYPE;
  String get getScheduleDETAIL => _scheduleDETAIL;
  String get getScheduleDATE => _scheduleDATE;
  String get getStartTIME => _startTIME;
  String get getFinishTIME => _finishTIME;
  String get getScheduleLOCATION => _scheduleLOCATION;
  List get getFriendLIST => _friendLIST;

  set setCalendarNUM(int calendarNUM) => _calendarNUM = calendarNUM;
  set setScheduleTYPE(String scheduleTYPE) => _scheduleTYPE = scheduleTYPE;
  set setScheduleDETAIL(String scheduleDETAIL) =>
      _scheduleDETAIL = scheduleDETAIL;
  set setScheduleDATE(String scheduleDATE) => _scheduleDATE = scheduleDATE;
  set setStartTIME(String startTIME) => _startTIME = startTIME;
  set setFinishTIME(String finishTIME) => _finishTIME = finishTIME;
  set setScheduleLOCATION(String scheduleLOCATION) =>
      _scheduleLOCATION = scheduleLOCATION;
  void setFriendLIST(friend) {
    _friendLIST.add(friend);
  }

  void clearFriendList() {
    _friendLIST.clear();
  }

  Calendar(
      this._calendarNUM,
      this._scheduleTYPE,
      this._scheduleDETAIL,
      this._scheduleDATE,
      this._startTIME,
      this._finishTIME,
      this._scheduleLOCATION,
      this._hostNUM);
  void pALL() {
    print(_calendarNUM);
    print(_scheduleTYPE);
    print(_scheduleDETAIL);
    print(_scheduleDATE);
    print(_startTIME);
    print(_finishTIME);
    print(_scheduleLOCATION);
    print(_friendLIST.toString());
  }

  Calendar.fromJson(Map<String, dynamic> json)
      : _calendarNUM = json['calendarNUM'],
        _scheduleTYPE = json['scheduleTYPE'],
        _scheduleDETAIL = json['scheduleDETAIL'],
        _scheduleDATE = json['scheduleDATE'],
        _startTIME = json['startTIME'],
        _finishTIME = json['finishTIME'],
        _scheduleLOCATION = json['scheduleLOCATION'],
        _hostNUM = json['hostNUM'];

  Map<String, dynamic> toJson() => {
        'hostNUM': _hostNUM,
        'calendarNUM': _calendarNUM,
        'scheduleTYPE': _scheduleTYPE,
        'scheduleDETAIL': _scheduleDETAIL,
        'scheduleDATE': _scheduleDATE,
        'startTIME': _startTIME,
        'finishTIME': _finishTIME,
        'scheduleLOCATION': _scheduleLOCATION,
        'friendLIST': _friendLIST
      };
}
