import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  // List<User> userlist = [user,user1,user2,user3,user4];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              leading: Icon(Icons.people),
              title: Text("사용자${i + 1}"),
              trailing: Icon(Icons.ac_unit),
              onTap: () {},
            );
          }),
    );
  }
}
