import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:calendar/screen/Home/screen/changepassword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:calendar/screen/Home/screen/changename.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'User Information',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      child: Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(70, 10, 30, 10),
                              width: size.width * 0.231,
                              height: size.height * 0.14,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                              ),
                            ),
                            // 익명 아이콘 가득채우기 + 유저이름 뜨게하기
                            Container(
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'userID',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      'userNAME',
                                      style: TextStyle(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChangeName()));
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
                          builder: (context) => ChangePassword()));
                },
              ),
              SizedBox(
                height: 5,
              ),
              RoundedButton(
                text: 'LOG OUT',
                press: () {},
                // welcompage route + ID history remove
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('App ver 0.1'),
                    SizedBox(width: 5),
                    Text(
                      '문의하기',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
