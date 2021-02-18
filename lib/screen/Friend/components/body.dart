import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'background.dart';

class Friend {
  final int userIDK;
  final String userID;
  final String userNAME;
  final String userPW;
  final String userRole;

  Friend(
      {this.userIDK, this.userID, this.userNAME, this.userPW, this.userRole});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
        userIDK: json['userIDK'],
        userID: json['userID'],
        userNAME: json['userNAME'],
        userPW: json['userPW'],
        userRole: json['userRole']);
  }
}

class Body extends StatefulWidget {
  final String id;
  Body({this.id});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Friend> fetchFriend() async {
    final String url = "http://3.35.39.202:8000/calendar";
    final response = await get("$url/read/userfriend/${widget.id}");
    if (response.statusCode == 200) {
      return Friend.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Friend> friend;
  String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;
    friend = fetchFriend();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: FutureBuilder<Friend>(
            future: friend,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data.userNAME.length == 0)
                    ? Text("친구가 없어")
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            leading: Icon(Icons.emoji_people),
                            title: Text("${snapshot.data.userNAME}"),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_left_outlined),
                              color: Colors.black,
                              onPressed: () {
                                print(snapshot.data.userID);
                              },
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
            }));
  }
}
