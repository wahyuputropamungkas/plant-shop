import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plantshop/components/product.dart';
import 'package:plantshop/constants/custom_colors.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _Home();

}

class _Home extends State<Home> {

  int selectedBottomMenu = 0;
  List<Map<String, dynamic>> listDataBottomMenu = [];
  List<Map<String, String>> myProducts = [];
  List<dynamic> produk = [];

  @override
  void initState() {
    super.initState();

    listDataBottomMenu = dataBottomMenu();
    myProducts = listProduct();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getProducts().then((value) {
        setState(() {
          produk = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          horizontal: 24
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: CustomColors().greyC4C4C4,
                    width: 1
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100))
            ),
            padding: const EdgeInsets.only(
                right: 12,
                left: 24,
                top: 8,
                bottom: 8
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  label: const Text(
                    "Searching a plant",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Find your favorite plant here",
                  hintStyle: TextStyle(
                      fontSize: 12,
                      color: CustomColors().grey757575,
                      fontWeight: FontWeight.w400
                  ),
                  border: InputBorder.none,
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                        color: CustomColors().green,
                        shape: BoxShape.circle
                    ),
                    child: Image.asset("assets/Icons/search.png", scale: 2),
                  )
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: List.generate(listDataBottomMenu.length, (index) {
              Map<String, dynamic> currentData = listDataBottomMenu[index];
              int currentDataIndex = currentData["index"];
              String currentIcon = currentData["off"];
              Color currentTitleColor = CustomColors().grey757575;
              FontWeight currentTitleWeight = FontWeight.w400;

              if(currentDataIndex == selectedBottomMenu) {
                currentIcon = currentData["on"];
                currentTitleColor = CustomColors().green;
                currentTitleWeight = FontWeight.w600;
              }

              return Expanded(
                flex: 1,
                child: Material(
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: CustomColors().greyC4C4C4.withOpacity(0.2))
                        )
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedBottomMenu = currentDataIndex;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 8,
                            top: 8
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(currentIcon, scale: 3),
                            Text(
                              currentData["title"],
                              style: TextStyle(
                                  color: currentTitleColor,
                                  fontSize: 14,
                                  fontWeight: currentTitleWeight
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
              future: getProducts(),
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasData) {
                    return Row(
                      children: List.generate(produk.length, (index) {
                        Map<String, dynamic> currentData = produk[index];

                        return Row(
                          children: [
                            Product(
                              image: currentData["image"],
                              title: currentData["name"],
                              description: currentData["description"],
                              type: currentData["type"],
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      }),
                    );
                  } else if(snapshot.hasError) {
                    return Text(
                      "Error"
                    );
                  } else {
                    return Text(
                        "Failed"
                    );
                  }
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Future getProducts() async {
    List<dynamic> apiProducts = [];

    await http.get(
        Uri.parse("https://private-40208d-flutterworkshop.apiary-mock.com/products")
    ).then((value) {
      dynamic apiResponse = json.decode(value.body.toString());

      for(var row in apiResponse) {
        apiProducts.add({
          "image": row["image"],
          "name": row["name"],
          "description": row["description"],
          "type": row["type"],
        });
      }
    });

    return apiProducts;
  }

  List<Map<String, dynamic>> dataBottomMenu() {
    return [
      {
        "index": 0,
        "title": "For You",
        "on": "assets/Icons/for-u-on.png",
        "off": "assets/Icons/for-u-off.png"
      },
      {
        "index": 1,
        "title": "Indoor",
        "on": "assets/Icons/indoor-on.png",
        "off": "assets/Icons/indoor-off.png"
      },
      {
        "index": 2,
        "title": "Outdoor",
        "on": "assets/Icons/outdoor-on.png",
        "off": "assets/Icons/outdoor-off.png"
      },
      {
        "index": 3,
        "title": "Garden",
        "on": "assets/Icons/garden-on.png",
        "off": "assets/Icons/garden-off.png"
      },
    ];
  }

  List<Map<String, String>> listProduct() {
    List<Map<String, String>> data = [
      {
        "image": "assets/Images/plant1.png",
        "name": "Plant 1",
        "description": "It's a plant",
        "type": "outdoor"
      },
      {
        "image": "assets/Images/plant2.png",
        "name": "Plant 2",
        "description": "It's also a plant",
        "type": "indoor"
      },
      {
        "image": "assets/Images/plant3.png",
        "name": "Plant 1",
        "description": "Yes, it's a plant",
        "type": "outdoor"
      }
    ];

    return data;
  }

}