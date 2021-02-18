import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'withFriend.dart';

// Widget pickedFriend(friendList, _isChecked) {
//   bool vr = false;
//   print("리스트만들기 시작");
//   int tmp = 0;
//   print("${friendList}");

//   friendList == null ? tmp = 0 : tmp = friendList.length;
//   print("리스트만들기끝");
//   return ListView.builder(
//       physics: BouncingScrollPhysics(),
//       itemCount: tmp,
//       itemBuilder: (BuildContext context, int i) {
//         return CheckboxListTile(
//           value: _isChecked,
//           onChanged: (value) {
//             setstate
//           },
//           controlAffinity: ListTileControlAffinity.leading,
//           title: Text("${friendList[i]["userNAME"]}"),
//         );
//       });
// }
