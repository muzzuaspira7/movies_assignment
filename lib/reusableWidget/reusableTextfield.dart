import 'dart:ui';

import 'package:flutter/material.dart';

class ReusableTextField extends StatefulWidget {
  final TextEditingController textController;
  final String labelText, hintText;
  final IconData? leadingIcon;
  final TextInputType keyboardType;
  final bool isPassword;
  const ReusableTextField({
    Key? key,
    required this.textController,
    required this.labelText,
    required this.hintText,
    this.leadingIcon,
    required this.keyboardType,
    required this.isPassword,
  }) : super(key: key);

  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        // keyboardType: widget.KeyBoardType,
        controller: widget.textController,
        cursorColor: Colors.blue,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
          labelText: widget.labelText,

          hintText: widget.hintText,

          labelStyle: TextStyle(
              color: const Color.fromARGB(
                  255, 194, 224, 255)), // Customize label color
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0), // Customize border color when focused
            borderRadius:
                BorderRadius.circular(10.0), // Customize border radius
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.blue[100]!), // Customize border color
            borderRadius:
                BorderRadius.circular(10.0), // Customize border radius
          ),

          prefixIcon: widget.leadingIcon != null
              ? Icon(
                  widget.leadingIcon,
                  size: 22,
                  color: Colors.blue,
                )
              : null,
        ),
        autocorrect: false, // Disable autocorrect
        enableSuggestions: false, // Disable suggestion
        style: TextStyle(color: Colors.white), // Customize text color
      ),
    );
  }
}
