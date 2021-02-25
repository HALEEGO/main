import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:calendar/components/text_field_container.dart';
import '../../data/User.dart';
import 'dart:ui';
import 'package:calendar/components/rounded_button.dart';

class RoundedFriendField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedFriendField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
        hintText: "친구 ID",
        icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
      ),
    ));
  }
}

class AddFriend extends StatefulWidget {
  final String id;
  AddFriend({@required this.id});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  String id;
  Future<User> fetchedFriendID;
  Future<List<User>> checkFriend;
  bool buttonOn = false;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    String _friendID;
    Size size = MediaQuery.of(context).size;

    Future<List<User>> fetchFriend() async {
      final String url = "http://3.35.39.202:8000/calendar";
      final response = await get("$url/read/userfriend/${widget.id}");
      if (response.statusCode == 200) {
        var responseJson = (json.decode(response.body));
        return (responseJson as List).map((j) => User.fromJson(j)).toList();
      } else {
        throw Exception('Failed to load friendList');
      }
    }

    Future<User> fetchAddFriend() async {
      final String url = "http://3.35.39.202:8000/calendar";
      final response = await get("$url/read/user/$_friendID");
      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = json.decode(response.body);
        User user = User.fromJson(userMap);
        print("$user");
        return (user);
      } else {
        throw Exception('Failed to load addfriend');
      }
    }

    bool isAlreadyFriend(String friend) {}

    void showAlertDialog(BuildContext context, String tmp, String tmp2,
        bool istwo, String friend) async {
      String result = await showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$tmp'),
            content: Text("${tmp2}"),
            actions: istwo
                ? <Widget>[
                    FlatButton(
                        child: Text('확인'),
                        onPressed: () async {
                          checkFriend = fetchFriend();
                          bool check = false;
                          bool isSend = false;
                          checkFriend.then((val) async {
                            for (int i = 0; i < val.length; i++) {
                              (val[i].getUserID == friend)
                                  ? check = true
                                  : check = false;
                            }
                            if (check) {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('이미 추가된 친구입니다.'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('확인'))
                                      ],
                                    );
                                  });
                            } else {
                              Response response = await post(
                                  "http://3.35.39.202:8000/calendar/insert/friend/$id/$friend");
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('친구 추가 완료'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('확인'))
                                      ],
                                    );
                                  });
                            }
                          });
                        }),
                    FlatButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ]
                : <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(context, "OK");
                      },
                    ),
                  ],
          );
        },
      );
    }

    returnFreind(String id, String friend) async {
      Response response = await post(
          "http://3.35.39.202:8000/calendar/insert/friend/$id/$friend");
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: Text("친구 추가하기", style: TextStyle(color: Colors.white70)),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                RoundedFriendField(onChanged: (value) {
                  _friendID = value;
                }),
                Container(
                  width: size.width * 0.2,
                ),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          fetchedFriendID = fetchAddFriend();
                          buttonOn = true;
                        },
                      );
                    })
              ]),
            ),
            Container(height: size.height * 0.1),
            (buttonOn == false)
                ? Container(
                    child: Text("추가할 친구의 ID를 입력하세요.",
                        style: TextStyle(color: Colors.white70, fontSize: 20)))
                : Container(
                    child: FutureBuilder<User>(
                        future: fetchedFriendID,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ((snapshot.data.getUserIDK == 0)
                                ? Text("입력한 ID에 해당하는 친구가 존재하지 않습니다.",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 15))
                                : Column(
                                    children: [
                                      Text(
                                          "친구 아이디: ${snapshot.data.getUserID}   친구 이름: ${snapshot.data.getUserNAME}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                      Container(height: size.height * 0.05),
                                      RoundedButton(
                                          text: "친구 추가",
                                          press: () {
                                            showAlertDialog(
                                                context,
                                                "추가하시겠습니까?",
                                                "친구 이름: ${snapshot.data.getUserNAME}",
                                                true,
                                                snapshot.data.getUserID);
                                          })
                                    ],
                                  ));
                          }
                          return CircularProgressIndicator();
                        })),
          ],
        ),
      ),
    );
  }
}

// leading: IconButton(
//             icon: Icon(
//               Icons.keyboard_backspace_rounded,
//               color: Colors.white70,
//             ),
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         backgroundColor: Colors.blueGrey[800],
//                         title: new Text(
//                           "경고",
//                           style: TextStyle(color: Colors.white70),
//                         ),
//                         content: SingleChildScrollView(
//                             child: new Text(
//                           "뒤로가려면 뒤로가기를 누르세요",
//                           style: TextStyle(color: Colors.white70),
//                         )),
//                       ));
//             }),



