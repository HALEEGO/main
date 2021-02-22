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
    (followSelect)
        ? setState(() {
            fetchedFriend = fetchFriend(Follow);
          })
        : setState(() {
            fetchedFriend = fetchFriend(Followed);
          });
    String dropdownValue;
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(children: [
      Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.4),
          ),
          height: 50,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      followSelect = true;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.4),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(child: Text("Following")))),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      followSelect = false;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.4),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(child: Text("Follower"))))
            ],
          )),
      Expanded(
          child: Container(
              child: FutureBuilder<List<User>>(
                  future: fetchedFriend,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data.length == 0)
                          ? Text("친구가 없네요 ^^7")
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int i) {
                                return ListTile(
                                  leading: Icon(Icons.emoji_people),
                                  title:
                                      Text("${snapshot.data[i].getUserNAME}"),
                                  trailing: DropdownButton<String>(
                                    icon: Icon(Icons.more_vert_outlined),
                                    iconSize: 24,
                                    underline: Container(
                                      color: Colors.white,
                                    ),
                                    focusColor: Colors.blue,
                                    dropdownColor: Colors.white,
                                    value: dropdownValue,
                                    style: TextStyle(color: Colors.black),
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
                                                      "상세한 ${snapshot.data[i].getUserNAME} 정보"),
                                                  content: SingleChildScrollView(
                                                      child: new Text(
                                                          "이름이 ${snapshot.data[i].getUserNAME}임")),
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
                                        child: Text(value),
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
