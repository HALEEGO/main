class User {
  String _userIDK;

  String _userID;

  String _userPW;

  String _userNAME;

  String _userROLE;

  String get getUserIDK => _userIDK;
  String get getUserID => _userID;
  String get getUserPW => _userPW;
  String get getUserNAME => _userNAME;
  String get getUserROLE => _userROLE;

  set setUserIDK(String userIDK) => _userIDK = userIDK;
  set setUserID(String userID) => _userID = userID;
  set setUserPW(String userPW) => _userPW = userPW;
  set setUserNAME(String userNAME) => _userNAME = userNAME;
  set setUserROLE(String userROLE) => _userROLE = userROLE;

  User(_userIDK, _userID, _userPW, _userNAME, _userROLE);

  User.fromJson(Map<String, dynamic> json)
      : _userID = json['userID'],
        _userPW = json['userPW'],
        _userNAME = json['userNAME'];

  Map<String, dynamic> toJson() => {
        'userID': _userID,
        'userPW': _userPW,
        'userNAME': _userNAME,
      };
}
