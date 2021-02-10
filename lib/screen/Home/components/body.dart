import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatelessWidget {
  final List<String> entries = <String>['A', 'b', 'c'];
  final List<int> colorCodes = <int>[1, 2, 3];

  // List<User> userlist = [user,user1,user2,user3,user4];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Background(
          child: Column(children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10),
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
                          bottom: BorderSide(color: Colors.black, width: 0.3)),
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
            ),
            Container(
              width: size.width * 0.95,
              height: size.height * 0.07,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15, top: 10),
              // decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.black)),
              child: Text(
                "일정",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: entries.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: 300,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 10),
                      child: Text("${entries[index]}=====${colorCodes[index]}"),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(width: 0.8, color: Colors.yellow)),
                    );
                  }),
            )
          ]),
        ),
      ],
    );
  }
}
