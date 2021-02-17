import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatefulWidget {
  final String id;
  Body({this.id});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String id;
  @override
  void initState() {
    super.initState();
    id = widget.id;

    print("이것은 $id");
  }

  List user = [
    "고병찬",
    "김병찬",
    "강병찬",
    "공병찬",
    "가병찬",
    "길병찬",
    "구병찬",
    "기병찬",
    "긴병찬",
    "짧은병찬",
    "홍병찬"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: (user.length == 0)
            ? Text("친구가 없어")
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: user.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    leading: Icon(Icons.emoji_people),
                    title: Text("${user[i]}"),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_left_outlined),
                      color: Colors.black,
                      onPressed: () {},
                    ),
                    onTap: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int i) {
                  return const Divider();
                }));
  }
}
