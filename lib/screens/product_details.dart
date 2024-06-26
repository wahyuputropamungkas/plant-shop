import 'package:flutter/material.dart';
import 'package:plantshop/components/buttons/button_green.dart';
import 'package:plantshop/constants/custom_colors.dart';

class ProductDetails extends StatefulWidget {

  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetails();

}

class _ProductDetails extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        automaticallyImplyLeading: false,
        title: const Text(
          "Plant Detail",
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600
          ),
        ),
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24
            ),
            child: GestureDetector(
              onTap: () {

              },
              child: Image.asset("assets/Icons/love-off.png", scale: 3),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset("assets/Images/plant3.png", scale: 1, fit: BoxFit.fitWidth),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Fiddle leaf fig plant",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24
                                      ),
                                    ),
                                    Text(
                                      "Broadleaf evergreen",
                                      style: TextStyle(
                                          color: CustomColors().grey757575,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
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
                                    "Indoor",
                                    style: TextStyle(
                                        color: CustomColors().green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: CustomColors().greyC4C4C4.withOpacity(0.2),
                                  width: 1
                                ),
                                bottom: BorderSide(
                                    color: CustomColors().greyC4C4C4.withOpacity(0.2),
                                    width: 1
                                )
                              )
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Biotanical Name",
                                        style: TextStyle(
                                          color: CustomColors().grey757575,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const Text(
                                        "Ficus lyrata",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 16
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: CustomColors().greyC4C4C4,
                                          width: 1
                                        )
                                      )
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nickname",
                                          style: TextStyle(
                                              color: CustomColors().grey757575,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        const Text(
                                          "Fiddle-leaf fig",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Native to the Yunnan and Sichuan provinces of southern China, the Chinese money plant was first brought to the UK in 1906 by Scottish botanist George Forrest (yes, we know the exact man who found it). It became a popular houseplant later in the 20th century because it is simple to grow and really easy to propagate, meaning friends could pass cuttings around amongst themselves. That earned it the nickname ‘pass it on plant’.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: CustomColors().greyC4C4C4.withOpacity(0.2),
                    width: 1
                  )
                )
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rp 25.000",
                          style: TextStyle(
                            color: CustomColors().green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                              color: CustomColors().grey757575,
                              fontSize: 12,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ButtonGreen(
                      text: "Add to Cart",
                      onTap: () {

                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}