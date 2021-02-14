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

  String userInfo = "";
  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
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
                  await storage.write(key: "login", value: "$_id");

                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Mainmenu(
                                id: _id,
                              )));
                  // Response response = await get(
                  // "http://192.168.219.134:8000/calendar/read/user/${id}");
                  // User user = User.fromJson(json.decode(response.body));  //테스트해봐야댐
                  // Map<String, dynamic> person = json.decode(response.body);
                  // print(person['userPW']);
                  // print(user.getUserID);
                  // if (person['userPW'] == pw) {
                  // print("ok!");
                  // Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  // builder: (context) {
                  // return Mainmenu();
                  // },
                  // ),
                  // );
                  // } else
                  // print('no!');
                  // print(id);
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
