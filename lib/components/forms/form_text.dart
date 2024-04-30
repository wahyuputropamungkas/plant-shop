import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class FormText extends StatefulWidget {

  const FormText({
    super.key,
    required this.controller,
    required this.hintText
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<FormText> createState() => _FormText();

}

class _FormText extends State<FormText> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: CustomColors().greyC4C4C4,
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors().greyC4C4C4,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors().greyC4C4C4,
              width: 1
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12))
        )
      ),
    );
  }

}