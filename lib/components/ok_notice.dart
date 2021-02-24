import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';

class Ok extends StatelessWidget {
  final String titleText, bodyText;

  const Ok({Key key, this.titleText, this.bodyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: kNoticeColor[800],
      title: new Text(
        titleText,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'))
      ],
      content: SingleChildScrollView(
        child: new Text(
          bodyText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// 사용법 : showDialog(context: context, builder: (BuildContext context){return Ok(제목, 내용)})
// 이렇게 씌워주는 과정이 필요합니다. 불편하면 알아서 함수수정하시고
