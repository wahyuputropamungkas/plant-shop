import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class ButtonGreen extends StatelessWidget {

  const ButtonGreen({
    super.key,
    required this.text,
    required this.onTap
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: CustomColors().green,
            borderRadius: const BorderRadius.all(Radius.circular(100))
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }

}