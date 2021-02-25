import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "You can make Account " : "I'm already have Account ! ",
          style: TextStyle(color: Colors.white60),
        ),
        GestureDetector(
          onTap: press,
          child: Text(login ? "Here" : "Login",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        )
      ],
    );
  }
}
