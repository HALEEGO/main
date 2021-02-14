import 'dart:convert';

import 'package:calendar/components/already_have_an_account_check.dart';
import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/components/rounded_password_field.dart';
import 'package:calendar/data/User.dart';
import 'package:calendar/screen/Login/login_screen.dart';
import 'package:calendar/screen/Signup/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

class Body extends StatelessWidget {
  String id;
  String pw;
  String name = "사용자";
  User user = User(null, null, null, null, null);
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
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/images/HA/meeting.svg',
                height: size.height * 0.3,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  id = value;
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  pw = value;
                  print(pw);
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  user.setUserID = id;
                  user.setUserPW = pw;
                  user.setUserNAME = name;

                  var json = jsonEncode(user);
                  print(json);
                  Response response = await post(
                      "http://192.168.219.134:8000/calendar/insert/user",
                      body: json,
                      headers: {'Content-Type': "application/json"});
                  print(response.body);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
