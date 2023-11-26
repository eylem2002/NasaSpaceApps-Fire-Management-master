import 'package:flutter/material.dart';

import '../../Utils/lib_organizer.dart';


class TextFieldComponent extends StatelessWidget {
  TextFieldComponent(
      {Key? key,
        required this.controller,
        this.edgeInsets = const EdgeInsets.all(5),
        this.textStyle,
        this.obscureText = false,
        required this.labelText,
        required this.hintText})
      : super(key: key);
  EdgeInsets edgeInsets;
  TextStyle? textStyle;
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets,
      child: TextFormField(
        style:
        textStyle ?? TextStyle(color: ThemeManager.textColor, fontSize: 16),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: ThemeManager.textColor),
          labelStyle: TextStyle(color: ThemeManager.accent),
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeManager.textColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ThemeManager.accent)),
          errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}