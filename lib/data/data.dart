class PlanInfo {
  String _planName;
  String _located;
  bool _allDaySwitched = false;
  bool _endTimeisSwitched = true;
  bool _alramisSwitched = false;
  String _time = '';
  String _starttime = '';
  String _endtime = '';
  List<String> withfreind = [];

  void addfreind(String friend) {
    withfreind.add(friend);
  }

  String get GetPlanName => _planName;
  set setPlanName(String planName) => _planName = planName;

  String get Getlocated => _located;
  set Setlocated(String located) => _located = located;

  bool get GetallDaySwitched => _allDaySwitched;
  set SetallDaySwitched(bool allDaySwitched) =>
      _allDaySwitched = allDaySwitched;

  bool get GetendTimeisSwitched => _endTimeisSwitched;
  set SetendTimeisSwitched(bool endTimeisSwitched) =>
      _endTimeisSwitched = endTimeisSwitched;

  bool get GetalramisSwitched => _alramisSwitched;
  set SetalramisSwitched(bool alramisSwitched) =>
      _alramisSwitched = alramisSwitched;

  String get Getstarttime => _starttime;
  set Setstarttime(String starttime) => _starttime = starttime;

  String get Getendtime => _endtime;
  set Setendtime(String endtime) => _endtime = endtime;

  String get Gettime => _time;
  set Settime(String time) => _time = time;

  void prtall() {
    print('planName : ' + _planName);
    print('_located : ' + _located);
    print('_allDaySwitched : ' + _allDaySwitched.toString());
    print('_endTimeisSwitched : ' + _endTimeisSwitched.toString());
    print('_alramisSwitched : ' + _alramisSwitched.toString());
    print('_time : ' + _time);
    print('_starttime : ' + _starttime);
    print('_endtime : ' + _endtime);
  }
}
