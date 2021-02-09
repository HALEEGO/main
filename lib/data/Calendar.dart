class Calendar {
  int _calendarNUM;

  String _scheduleTYPE;

  String _scheduleDETAIL;

  String _scheduleDATE;

  String _startTIME;

  String _finishTIME;

  String _scheduleLOCATION;

  int get getCalendarNUM => _calendarNUM;
  String get getScheduleTYPE => _scheduleTYPE;
  String get getScheduleDETAIL => _scheduleDETAIL;
  String get getScheduleDATE => _scheduleDATE;
  String get getStartTIME => _startTIME;
  String get getFinishTIME => _finishTIME;
  String get getScheduleLOCATION => _scheduleLOCATION;

  set setCalendarNUM(int calendarNUM) => _calendarNUM = calendarNUM;
  set setScheduleTYPE(String scheduleTYPE) => _scheduleTYPE = scheduleTYPE;
  set setScheduleDETAIL(String scheduleDETAIL) =>
      _scheduleDETAIL = scheduleDETAIL;
  set setScheduleDATE(String scheduleDATE) => _scheduleDATE = scheduleDATE;
  set setStartTIME(String startTIME) => _startTIME = startTIME;
  set setFinishTIME(String finishTIME) => _finishTIME = finishTIME;
  set setScheduleLOCATION(String scheduleLOCATION) =>
      _scheduleLOCATION = scheduleLOCATION;

  void pALL() {
    print(_calendarNUM);
    print(_scheduleTYPE);
    print(_scheduleDETAIL);
    print(_scheduleDATE);
    print(_startTIME);
    print(_finishTIME);
    print(_scheduleLOCATION);
  }
}
