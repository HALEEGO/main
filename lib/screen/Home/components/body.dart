import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Background(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 30, top: 10),
                width: size.width * 0.95,
                height: size.height * 0.35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.4),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 15),
                      width: size.width * 0.95,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black, width: 0.3)),
                      ),
                      child: Text(
                        "오늘의 TODO",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black, width: 0.1)),
                                ),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Colors.black, width: 0.1)),
                                ),
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.person),
                                      title: Text("abcd"),
                                      trailing: Icon(Icons.ac_unit_outlined),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
