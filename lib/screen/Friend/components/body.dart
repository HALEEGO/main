import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'background.dart';
import '../../../data/User.dart';
import 'package:calendar/screen/Calendar/calendar.dart';

class Body extends StatefulWidget {
  final String id;
  Body({this.id});

  @override
  _BodyState createState() => _BodyState();
}

String Follow = "read/userfriend";
String Followed = "read/frienduser";

class _BodyState extends State<Body> {
  Future<List<User>> fetchFriend(String midURL) async {
    final String url = "http://3.35.39.202:8000/calendar";
    final response = await get("$url/$midURL/${widget.id}");
    if (response.statusCode == 200) {
      var responseJson = (json.decode(response.body));
      return (responseJson as List).map((j) => User.fromJson(j)).toList();
    } else {
      throw Exception('Failed to load friendList');
    }
  }

  bool followSelect = true;
  Future<List<User>> fetchedFriend;
  String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    (followSelect)
        ? setState(() {
            fetchedFriend = fetchFriend(Follow);
          })
        : setState(() {
            fetchedFriend = fetchFriend(Followed);
          });
    String dropdownValue;
    return Background(
        child: Column(children: [
      Container(
          height: size.height * 0.05,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      followSelect = true;
                    });
                  },
                  child: (followSelect)
                      ? Container(
                          width: size.width * 0.49,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 2)),
                          ),
                          child: Center(
                              child: Text("팔로잉",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17)))) //focused 됐을 때
                      : Container(
                          width: size.width * 0.49,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                          child: Center(
                              child: Text("팔로잉",
                                  style: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 17))))), //!focused 됐을때
              Container(
                width: size.width * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      followSelect = false;
                    });
                  },
                  child: (followSelect != true)
                      ? Container(
                          width: size.width * 0.49,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.white, width: 2)),
                          ),
                          child: Center(
                              child: Text("팔로워",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17)))) //focused
                      : Container(
                          width: size.width * 0.49,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2)),
                          ),
                          child: Center(
                              child: Text("팔로워",
                                  style: TextStyle(
                                      color: Colors.white30,
                                      fontSize: 17))))) // !focused
            ],
          )),
      Expanded(
          child: Container(
              child: FutureBuilder<List<User>>(
                  future: fetchedFriend,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data.length == 0)
                          ? Container(
                              child: Column(children: [
                              Container(
                                height: size.height * 0.1,
                              ),
                              Text("친구 목록이 없습니다.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))
                            ]))
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int i) {
                                return ListTile(
                                  leading: Icon(Icons.emoji_people),
                                  title: Text("${snapshot.data[i].getUserNAME}",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: DropdownButton<String>(
                                    icon: Icon(Icons.more_vert_outlined),
                                    iconSize: 24,
                                    underline: Container(
                                      color: Colors.white,
                                    ),
                                    focusColor: Colors.blue,
                                    dropdownColor: Colors.white,
                                    value: dropdownValue,
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                      (dropdownValue == '상세정보')
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0)),
                                                  title: new Text(
                                                      "${snapshot.data[i].getUserNAME} 정보"),
                                                  content: SingleChildScrollView(
                                                      child: new Text(
                                                          "이름: ${snapshot.data[i].getUserNAME}, 아이디: ${snapshot.data[i].getUserID}")),
                                                );
                                              },
                                            )
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Calendar(
                                                          title: snapshot
                                                              .data[i]
                                                              .getUserID)),
                                            );
                                    },
                                    items: <String>['상세정보', '달력보기']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      );
                                    }).toList(),
                                  ),
                                  onTap: () {},
                                );
                              },
                              separatorBuilder: (BuildContext context, int i) {
                                return const Divider();
                              });
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  })))
    ]));
  }
}
