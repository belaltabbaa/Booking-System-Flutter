import 'package:booking_system/resources/color_app.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TxtfiledWidget extends StatelessWidget {
  const TxtfiledWidget(
      {super.key,
      required this.controller,
      required this.labelText,
       this.hintText,
       this.obscureText = false,
       });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          labelStyle: TextStyle(color: ColorApp.yellowDark),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
