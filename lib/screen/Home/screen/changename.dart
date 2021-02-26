import 'dart:convert';

import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Home/screen/userInfo_screen.dart';
import 'package:calendar/screen/Main/mainbody.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ChangeName extends StatefulWidget {
  final String id;
  ChangeName({@required this.id});

  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  String id;
  String newname;

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

    return userInfo["userNAME"];
  }

  void reName() async {
    user.setUserNAME = newname;
    var json = jsonEncode(user);

    Response response = await put(
        "http://3.35.39.202:8000/calendar/put/user/$id",
        body: json,
        headers: {'Content-Type': "application/json"});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: getNameApi(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 70),
                  Text(
                    '이름변경 페이지',
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
                          hintText: '',
                          onChanged: (value) {
                            newname = value;
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          '《 ${snapshot.data}님, 새로운 이름을 입력하세요 》\n',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '※ 이름변경을 원하지 않으면 뒤로가기를 눌러주세요.\n',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '※ 이름은 20자를 넘지 않게 해주세요\n',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '※ 비속어를 포함한 아이디는 이용상 제한이 있을 수 있습니다.',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    // margin: const EdgeInsets.only(top: 25),
                    width: size.width * 0.95,
                    height: size.height * 0.42,
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
                    press: () async {
                      reName();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Widget okButton = FlatButton(
                            child: Text("확인"),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainBody(id: id)));
                            },
                          );
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            title: new Text("이름변경 성공"),
                            content: SingleChildScrollView(
                                child: new Text("홈 화면으로 돌아갑니다.")),
                            actions: [okButton],
                          );
                        },
                      );
                      // 변경완료 팝업창후 내정보페이지
                    },
                  ),
                ],
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
