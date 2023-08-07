import 'package:flutter/material.dart';
import 'package:hotspot/core/constants/consts.dart';

class RoundedTealTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;

  RoundedTealTextFormField({
    required this.controller,
    required this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;

    return Container(
      width: size.width*0.7,
      height: size.height*0.07,
      decoration: BoxDecoration(
        border: Border.all(color: tealColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        style:const TextStyle(color: tealColor),
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          labelText: labelText,
          hintText: hintText,
          labelStyle:const TextStyle(color: tealColor,fontSize: 14),
          hintStyle:const TextStyle(color: tealColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
