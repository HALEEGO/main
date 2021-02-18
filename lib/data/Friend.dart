import 'User.dart';

class Friend {
  var _FriendList = List<User>();

  List<User> get getFriendList => _FriendList;

  void addFriendList(User user) {
    _FriendList.add(user);
  }
}
