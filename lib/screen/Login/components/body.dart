import 'dart:convert';

import 'package:calendar/components/already_have_an_account_check.dart';
import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/components/rounded_password_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Home/home_screen.dart';
import 'package:calendar/screen/Login/components/background.dart';
import 'package:calendar/screen/Main/mainbody.dart';
import 'package:calendar/screen/Main/mainmenu.dart';
import 'package:calendar/screen/Signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _id = '';
  String _pw = '';
  String URL = "http://3.35.39.202:8000/calendar";
  String userInfo = "";
  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  void showAlertDialog(BuildContext context, String tmp) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$tmp 오류'),
          content: Text("$tmp가 잘못 되었습니다."),
          actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              SvgPicture.asset(
                "assets/images/HA/meeting.svg",
                height: size.height * 0.35,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  _id = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  _pw = value;
                },
              ),
              RoundedButton(
                text: "Sign In",
                press: () async {
                  Response response = await get("$URL/read/user/${_id}");
                  Map<String, dynamic> userInfo = json.decode(response.body);
                  if (userInfo['userID'] == null) {
                    showAlertDialog(context, "아이디");
                  } else if (userInfo['userPW'] == _pw) {
                    await storage.write(key: "login", value: "$_id");

                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Mainmenu(id: _id)));
                  } else {
                    showAlertDialog(context, "비밀번호");
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
