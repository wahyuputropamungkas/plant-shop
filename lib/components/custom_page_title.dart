import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class CustomPageTitle extends StatelessWidget {

  const CustomPageTitle({
    super.key,
    required this.title,
    this.text
  });

  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: CustomColors().green,
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
    );
  }

}