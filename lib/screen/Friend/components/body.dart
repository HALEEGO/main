import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  // List<User> userlist = [user,user1,user2,user3,user4];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Background(
          child: Container(),
        ),
      ],
    );
  }
}
