import 'package:calendar/components/rounded_button.dart';
import 'package:calendar/components/rounded_input_field.dart';
import 'package:flutter/material.dart';

class ChangeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 70),
            Text(
              'RENAME PAGE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 70),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  RoundedInputField(
                    hintText: '',
                  ),
                  SizedBox(height: 10),
                  Text('대충\n주\n의\n사\n항\n또는 닉네임규칙'),
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
              press: () {
                // ~ 으로 변경완료되었다는 알림창 후 내정보페이지로
              },
            ),
          ],
        ),
      ),
    );
  }
}
