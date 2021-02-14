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
              title: Text("$id의친구${i + 1}"),
              trailing: Icon(Icons.ac_unit),
              onTap: () {},
            );
          }),
    );
  }
}
