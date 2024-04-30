import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {

  const FormLabel({
    super.key,
    required this.label
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600
      ),
    );
  }

}