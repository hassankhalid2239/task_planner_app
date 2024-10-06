import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? sufix;
  final int maxLines;
  final int minLines;

  const CustomInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.sufix,
      this.minLines = 1,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        minLines: minLines,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText!';
          } else {
            return null;
          }
        },
        style:
            TextStyle(color: Colors.black),
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffF2F2F2),
          labelStyle:
              TextStyle(color: Colors.black),
          labelText: labelText,
          suffixIcon: sufix,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Color(0xffF2F2F2))),
        ),
      ),
    );
  }
}
