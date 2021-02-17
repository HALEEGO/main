import 'User.dart';

class Friend {
  List<User> _FriendList;

  List<User> get getFriendList => _FriendList;

  void addFriendList(User user) {
    _FriendList.add(user);
  }
}
