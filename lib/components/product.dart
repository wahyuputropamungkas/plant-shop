import 'package:flutter/material.dart';
import 'package:plantshop/constants/custom_colors.dart';

class Product extends StatelessWidget {

  const Product({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.type
  });

  final String image;
  final String title;
  final String description;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: CustomColors().greyC4C4C4,
              width: 1
          ),
          borderRadius: const BorderRadius.all(Radius.circular(25))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              ),
              child: Image.asset(image, fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                      color: CustomColors().grey757575,
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 8
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  border: Border.all(
                                      color: CustomColors().green,
                                      width: 1
                                  )
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8
                              ),
                              child: Text(
                                type,
                                style: TextStyle(
                                    color: CustomColors().green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RP",
                                style: TextStyle(
                                    color: CustomColors().green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "25K",
                                style: TextStyle(
                                    color: CustomColors().green,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    height: 1
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}