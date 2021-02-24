import 'dart:convert';

import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Home/screen/changepassword.dart';
import 'package:calendar/screen/Welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:calendar/screen/Home/screen/changename.dart';

class UserInfo extends StatefulWidget {
  final String id;
  UserInfo({this.id});
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String id;

  User user = User(null, null, null, null, null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
  }

  Future<String> getNameApi(id) async {
    Response response =
        await get("http://3.35.39.202:8000/calendar/read/user/$id");
    var userInfo = jsonDecode(response.body);
    print("object");
    return userInfo["userNAME"];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final storage = FlutterSecureStorage();
    return Scaffold(
      body: FutureBuilder(
        future: getNameApi(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'User Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: size.width * 0.95,
                      height: size.height * 0.2,
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.black, width: 0.4),
                      //   borderRadius: BorderRadius.all(Radius.circular(20)),
                      // ),
                      child: Column(
                        children: <Widget>[
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: const EdgeInsets.only(left: 15),
                          //   width: size.width * 0.95,
                          //   height: size.height * 0.07,
                          //   decoration: BoxDecoration(
                          //     border: Border(
                          //       bottom: BorderSide(color: Colors.black, width: 0.3),
                          //     ),
                          //   ),
                          //   child: Text(
                          //     'Profile',
                          //     style: TextStyle(fontWeight: FontWeight.w400),
                          //   ),
                          // ),
                          Container(
                            // width: size.width * 0.8,
                            // color: Colors.white10,
                            child: Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        70, 10, 30, 10),
                                    width: size.width * 0.231,
                                    height: size.height * 0.14,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                    ),
                                    child: Icon(
                                      Icons.person_outline,
                                      size: 65,
                                    ),
                                  ),
                                  // 익명 아이콘 가득채우기 + 유저이름 뜨게하기
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '$id',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 30),
                                          Text(
                                            '${snapshot.data}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RoundedButton(
                      text: 'CHANGE NAME',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeName(id: id)));
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RoundedButton(
                      text: 'CHANGE PASSWORD',
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword(id: id)));
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RoundedButton(
                      text: 'LOG OUT', textColor: Colors.redAccent,
                      press: () {
                        storage.delete(key: "login");
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => WelcomeScreen()),
                        );
                      },
                      // welcompage route + ID history remove
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'App ver 0.1',
                            style: TextStyle(color: Colors.white60),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Widget okButton = FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    title: new Text(
                                      "DEVELOPOER",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: SingleChildScrollView(
                                        child: new Text(
                                      "\n\n010-3625-1217",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    actions: [okButton],
                                  );
                                },
                              );
                            },
                            child: Text(
                              '문의하기',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return new Container();
          }
        },
      ),
    );
  }
}
