import 'dart:convert';

import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Home/screen/userInfo_screen.dart';
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
                    'RENAME PAGE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                          '《 ${snapshot.data}님, Enter your new name 》\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '※ If you don\'t want to change, press back button\n'),
                        Text('※ Namelength range is 2 to 8\n'),
                        Text('※ 상기내용을 읽고 이해하였으며 이에 동의합니다.')
                      ],
                    ),
                    // margin: const EdgeInsets.only(top: 25),
                    width: size.width * 0.95,
                    height: size.height * 0.42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.4),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  SizedBox(height: 30),
                  RoundedButton(
                    text: 'CHANGE',
                    press: () async {
                      reName();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInfo(id: id)));
                            },
                          );
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            title: new Text("NAME CHANGED"),
                            content: SingleChildScrollView(
                                child: new Text("return User Information")),
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
