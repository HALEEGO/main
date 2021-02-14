import 'package:flutter/material.dart';
import 'background.dart';

class Body extends StatefulWidget {
  final String id;
  Body({this.id});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var todaystamp = DateTime.now().day;
  var monthstamp = DateTime.now().month;

  String id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

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
                                    title: Text("$id"),
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
                  itemCount: 5,
                  itemBuilder: (context, int indexx) {
                    return new Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: 300,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, int index) {
                            if (index != 0) {
                              return ListTile(
                                leading: Icon(Icons.ac_unit),
                                title: Text("data"),
                                trailing: Icon(Icons.ac_unit_outlined),
                              );
                            } else {
                              return Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 200,
                                height: 30,
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "$monthstamp월 ${todaystamp + indexx}일"),
                              );
                            }
                          }),
                    );
                  }),
            )
          ]),
        ),
      ],
    );
  }
}











// class Body extends StatelessWidget {
//   final List<String> entries = <String>['A', 'b', 'c'];
//   final List<int> colorCodes = <int>[1, 2, 3];
//   var todaystamp = DateTime.now().day;
//   var monthstamp = DateTime.now().month;
//   String userInfo = '';
//   static final storage = new FlutterSecureStorage();

  

//   _asyncMethod() async {
//     //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
//     //(데이터가 없을때는 null을 반환을 합니다.)
//     userInfo = await storage.read(key: "login");
//     print(userInfo);
//   }
//   // List<User> userlist = [user,user1,user2,user3,user4];

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ListView(
//       physics: BouncingScrollPhysics(),
//       children: <Widget>[
//         Background(
//           child: Column(children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(top: 10),
//               width: size.width * 0.95,
//               height: size.height * 0.35,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 0.4),
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.only(left: 15),
//                     width: size.width * 0.95,
//                     height: size.height * 0.07,
//                     decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(color: Colors.black, width: 0.3)),
//                     ),
//                     child: Text(
//                       "오늘의 TODO",
//                       style: TextStyle(fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Container(
//                     child: Expanded(
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                     right: BorderSide(
//                                         color: Colors.black, width: 0.1)),
//                               ),
//                               child: ListView(
//                                 physics: BouncingScrollPhysics(),
//                                 children: <Widget>[
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text(""),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                     right: BorderSide(
//                                         color: Colors.black, width: 0.1)),
//                               ),
//                               child: ListView(
//                                 physics: BouncingScrollPhysics(),
//                                 children: <Widget>[
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   ),
//                                   ListTile(
//                                     leading: Icon(Icons.person),
//                                     title: Text("abcd"),
//                                     trailing: Icon(Icons.ac_unit_outlined),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               width: size.width * 0.95,
//               height: size.height * 0.07,
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.only(left: 15, top: 10),
//               // decoration: BoxDecoration(
//               //     border: Border.all(width: 1, color: Colors.black)),
//               child: Text(
//                 "일정",
//                 style: TextStyle(fontWeight: FontWeight.w400),
//               ),
//             ),
//             Container(
//               height: 200,
//               child: ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 5,
//                   itemBuilder: (context, int indexx) {
//                     return new Container(
//                       margin: const EdgeInsets.only(left: 10, right: 10),
//                       width: 300,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         border: Border.all(width: 0.3),
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                       child: ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: 5,
//                           itemBuilder: (context, int index) {
//                             if (index != 0) {
//                               return ListTile(
//                                 leading: Icon(Icons.ac_unit),
//                                 title: Text("data"),
//                                 trailing: Icon(Icons.ac_unit_outlined),
//                               );
//                             } else {
//                               return Container(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 width: 200,
//                                 height: 30,
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                     "$monthstamp월 ${todaystamp + indexx}일"),
//                               );
//                             }
//                           }),
//                     );
//                   }),
//             )
//           ]),
//         ),
//       ],
//     );
//   }
// }
