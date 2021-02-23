import 'package:calendar/components/text_field_container.dart';
import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white, fontSize: 15),
          icon: Icon(icon, color: Colors.white),
          hintText: hintText,
        ),
      ),
    );
  }
}
