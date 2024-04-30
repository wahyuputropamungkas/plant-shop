import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class AppbarHome extends StatelessWidget {

  const AppbarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: Colors.white,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors().grey757575
              ),
              child: ClipOval(
                child: Image.asset("assets/Icons/user.png", scale: 6, fit: BoxFit.fill),
              ),
            ),
          ),
        )
      ],
    );
  }

}