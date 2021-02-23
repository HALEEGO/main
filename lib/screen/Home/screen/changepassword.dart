import 'dart:convert';

import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Home/screen/userInfo_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChangePassword extends StatefulWidget {
  final String id;
  ChangePassword({@required this.id});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String id;
  String priorpassword;
  String newpassword;

  User user = User(null, null, null, null, null);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
  }

  Future<String> getPasswordApi(id) async {
    Response response =
        await get('http://3.35.39.202:8000/calendar/read/user/$id');
    print(response.body);
    var userInfo = jsonDecode(response.body);
    print(userInfo['userPW']);
    return userInfo['userPW'];
  }

  void putPasswordApi(pw) async {
    if (priorpassword == pw) {
      print('비번일치');
      user.setUserPW = newpassword;
      var json = jsonEncode(user);

      Response response = await put(
          'http://3.35.39.202:8000/calendar/put/user/$id',
          body: json,
          headers: {'Content-Type': 'application/json'});

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: new Text("PASSWORD CHANGED"),
            content: SingleChildScrollView(
                child: new Text("Don\'t forget never ever")),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: new Text("CHANGING FAILED"),
            content:
                SingleChildScrollView(child: new Text("PASWWORD MISMACHED")),
          );
        },
      );
      // 기존 비번 틀렸다는 팝업창 띄우기
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: getPasswordApi(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 70),
                      Text(
                        'CHANGE PASSWORD PAGE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 60),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            RoundedInputField(
                              hintText: 'PRIOR PW',
                              icon: Icons.lock,
                              onChanged: (value) {
                                priorpassword = value;
                              },
                            ),
                            RoundedInputField(
                              hintText: 'NEW PW',
                              icon: Icons.lock_clock,
                              onChanged: (value) {
                                newpassword = value;
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              '《 $id, Enter your new PASSWORD 》\n',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '※ If you don\'t want to change, press back button\n'),
                            Text('※ Password range is 2 to 8\n'),
                            Text('※ 상기내용을 읽고 이해하였으며 이에 동의합니다.')
                          ],
                        ),
                        // margin: const EdgeInsets.only(top: 25),
                        width: size.width * 0.95,
                        height: size.height * 0.52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.4),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      SizedBox(height: 30),
                      RoundedButton(
                        text: 'CHANGE',
                        press: () {
                          putPasswordApi(snapshot.data);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return new Container();
              }
            }));
  }
}
