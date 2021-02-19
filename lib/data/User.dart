class User {
  int _userIDK;

  String _userID;

  String _userPW;

  String _userNAME;

  String _userROLE;

  int get getUserIDK => _userIDK;
  String get getUserID => _userID;
  String get getUserPW => _userPW;
  String get getUserNAME => _userNAME;
  String get getUserROLE => _userROLE;

  set setUserIDK(int userIDK) => _userIDK = userIDK;
  set setUserID(String userID) => _userID = userID;
  set setUserPW(String userPW) => _userPW = userPW;
  set setUserNAME(String userNAME) => _userNAME = userNAME;
  set setUserROLE(String userROLE) => _userROLE = userROLE;

  User(_userIDK, _userID, _userPW, _userNAME, _userROLE);

  User.fromJson(Map<String, dynamic> json)
      : _userIDK = json['userIDK'],
        _userID = json['userID'],
        _userPW = json['userPW'],
        _userNAME = json['userNAME'],
        _userROLE = json['userROLE'];

  Map<String, dynamic> toJson() => {
        'userID': _userID,
        'userPW': _userPW,
        'userNAME': _userNAME,
      };
}
