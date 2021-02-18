import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pickedFriend(friendList) {
  print("리스트만들기 시작");
  int tmp = 0;
  print("${friendList}");
  friendList == null ? tmp = 0 : tmp = friendList.length;
  print("리스트만들기끝");
  return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: tmp,
      itemBuilder: (BuildContext context, int i) {
        return ListTile(
          title: Text("${friendList[i]["userNAME"]}"),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        );
      });
}
