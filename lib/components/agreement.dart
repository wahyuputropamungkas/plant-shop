import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class Agreement extends StatefulWidget {

  const Agreement({super.key});

  @override
  State<Agreement> createState() => _Agreement();

}

class _Agreement extends State<Agreement> {

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              child: Container(
                width: Checkbox.width + 5,
                height: Checkbox.width + 5,
                decoration: BoxDecoration(
                    color: checked ? CustomColors().green : CustomColors().greyF4F4F4,
                    shape: BoxShape.circle
                ),
                child: checked ? const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: Checkbox.width,
                ) : Container(),
              ),
              onTap: () {
                setState(() {
                  checked = !checked;
                });
              },
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: RichText(
            text: TextSpan(
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Manrope"
                ),
                children: [
                  TextSpan(
                      text: "I've read and agreed to ",
                      style: TextStyle(
                          color: CustomColors().grey757575
                      )
                  ),
                  TextSpan(
                      text: "User Agreement ",
                      style: TextStyle(
                          color: CustomColors().green
                      )
                  ),
                  TextSpan(
                      text: "and ",
                      style: TextStyle(
                          color: CustomColors().grey757575
                      )
                  ),
                  TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          color: CustomColors().green
                      )
                  )
                ]
            ),
          ),
        )
      ],
    );
  }

}