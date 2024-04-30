import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class FormPassword extends StatefulWidget {

  const FormPassword({
    super.key,
    required this.controller,
    required this.hintText
  });

  final TextEditingController controller;
  final String hintText;

  @override
  State<FormPassword> createState() => _FormPassword();

}

class _FormPassword extends State<FormPassword> {

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscurePassword,
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
          ),
          suffixIcon: GestureDetector(
            child: Image.asset(obscurePassword ? "assets/Icons/eye-off.png" : "assets/Icons/eye-on.png", scale: 3),
            onTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
      ),
    );
  }

}