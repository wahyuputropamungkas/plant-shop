import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class ButtonGoogle extends StatelessWidget {

  const ButtonGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors().greyC4C4C4.withOpacity(0.49),
            ),
            shape: BoxShape.circle
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          onTap: () {

          },
          child: Image.asset("assets/Icons/google.png", scale: 3),
        ),
      ),
    );
  }

}