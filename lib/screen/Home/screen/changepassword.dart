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
            title: new Text("비밀번호 변경 성공"),
            content: SingleChildScrollView(child: new Text("3일 후 재변경이 가능합니다.")),
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
            title: new Text("비밀번호 변경 실패"),
            content: SingleChildScrollView(child: new Text("기존 비밀번호를 확인해주세요.")),
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
                        '비밀번호 변경 페이지',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(height: 60),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            RoundedInputField(
                              hintText: '기존 비밀번호',
                              icon: Icons.lock,
                              onChanged: (value) {
                                priorpassword = value;
                              },
                            ),
                            RoundedInputField(
                              hintText: '새로운 비밀번호',
                              icon: Icons.lock_clock,
                              onChanged: (value) {
                                newpassword = value;
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              '《 $id님, 새로운 비밀번호를 입력하세요 》\n',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '※ 비밀번호 변경을 원하지 않으면 뒤로가기를 눌러주세요.\n',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '※ 비밀번호는 복잡도가 높을수록 좋습니다.\n',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '※ 비밀번호는 3일에 한 번 변경 가능합니다.',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        // margin: const EdgeInsets.only(top: 25),
                        width: size.width * 0.95,
                        height: size.height * 0.52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          border: Border.all(color: Colors.white30, width: 0.4),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      SizedBox(height: 30),
                      RoundedButton(
                        text: '변경하기',
                        textColor: Colors.red[400],
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
