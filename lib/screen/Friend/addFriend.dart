import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:calendar/components/text_field_container.dart';
import '../../data/User.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'dart:ui';
import 'package:calendar/components/rounded_button.dart';
import './Friend_screen.dart';

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
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
        hintText: "친구 ID",
        icon: Icon(Icons.lock, color: Colors.white),
      ),
    ));
  }
}

class AddFriend extends StatefulWidget {
  //scheduleTYPE
  final String id;
  AddFriend({@required this.id});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    String _friendID;
    Future<User> fetchedFriendID;
    Future<User> fetchAddFriend() async {
      final String url = "http://3.35.39.202:8000/calendar";
      final response = await get("$url/read/user/$_friendID");
      if (response.statusCode == 200) {
        var responseJson = (json.decode(response.body));
        return (responseJson);
      } else {
        throw Exception('Failed to load addfriend');
      }
    }

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
                      child: Text('마즘'),
                      onPressed: () async {
                        Response response = await post(
                            "http://3.35.39.202:8000/calendar/insert/friend/$id/$friend");
                        (response.body == 'ok')
                            ? showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Friendscreen()));
                                    },
                                  );
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    title: new Text("SIGNUP COMPLETE"),
                                    content: SingleChildScrollView(
                                        child:
                                            new Text("return FRIEND SCREEN")),
                                    actions: [okButton],
                                  );
                                },
                              )
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Friendscreen()));
                                    },
                                  );
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    title: new Text("SIGNUP FALSE"),
                                    content: SingleChildScrollView(
                                        child:
                                            new Text("return FRIEND SCREEN")),
                                    actions: [okButton],
                                  );
                                },
                              );
                      },
                    ),
                    FlatButton(
                      child: Text('틀림'),
                      onPressed: () {
                        Navigator.pop(context, "OK");
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
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.blueGrey[800],
                        title: new Text(
                          "오잉",
                          style: TextStyle(color: Colors.white70),
                        ),
                        content: SingleChildScrollView(
                            child: new Text(
                          "ㅋㅋ",
                          style: TextStyle(color: Colors.white70),
                        )),
                      ));
            }),
        title: Text("친추하기"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(children: <Widget>[
                RoundedFriendField(onChanged: (value) {
                  _friendID = value;
                }),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        fetchedFriendID = fetchAddFriend();
                        Container(
                            child: FutureBuilder<User>(
                                future: fetchedFriendID,
                                builder: (context, snapshot) {
                                  return (snapshot.data.getUserIDK == 0
                                      ? Text("아이디 제대로 확인하세요 ^^7",
                                          style: TextStyle(color: Colors.white))
                                      : Text(
                                          "${snapshot.data.getUserNAME}, ${snapshot.data.getUserID}"));
                                }));
                        Container(
                            child: FutureBuilder<User>(
                                future: fetchedFriendID,
                                builder: (context, snapshot) {
                                  return RoundedButton(
                                    text: "친구추가",
                                    press: () {
                                      if (snapshot.data == null ||
                                          snapshot.data.getUserIDK == 0) {
                                        showAlertDialog(
                                            context,
                                            "친구 아이디 오류",
                                            "다시 해바",
                                            false,
                                            snapshot.data.getUserID);
                                      } else {
                                        showAlertDialog(
                                            context,
                                            "진짜 친추?",
                                            "${snapshot.data.getUserNAME} 이름 맞제?",
                                            true,
                                            snapshot.data.getUserID);
                                      }
                                    },
                                  );
                                }));
                      });
                    })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
