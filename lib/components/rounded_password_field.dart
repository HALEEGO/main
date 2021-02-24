import 'package:calendar/components/text_field_container.dart';
import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
        hintText: "PassWord",
        icon: Icon(Icons.lock, color: Colors.white),
      ),
    ));
  }
}
