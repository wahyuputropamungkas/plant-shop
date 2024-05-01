import 'package:flutter/material.dart';
import 'package:plantshop/components/appbars/appbar_home.dart';
import 'package:plantshop/constants/custom_colors.dart';
import 'package:plantshop/screens/cart.dart';
import 'package:plantshop/screens/favorite.dart';
import 'package:plantshop/screens/home.dart';
import 'package:plantshop/screens/profile.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Home();

}

class _Home extends State<Dashboard> {

  int selectedBottomMenu = 0;
  List<Map<String, dynamic>> listDataBottomMenu = [];

  @override
  void initState() {
    super.initState();

    listDataBottomMenu = dataBottomMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: const AppbarHome(
            name: "John Doe",
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 30
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: selectedBottomMenu == 0 ? true : false,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: const Home(),
                    ),
                    Visibility(
                      visible: selectedBottomMenu == 1 ? true : false,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: const Favorite(),
                    ),
                    Visibility(
                      visible: selectedBottomMenu == 2 ? true : false,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: const Cart(),
                    ),
                    Visibility(
                      visible: selectedBottomMenu == 3 ? true : false,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: const Profile(),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24
                ),
                child: Row(
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
                                  top: BorderSide(color: CustomColors().greyC4C4C4.withOpacity(0.2))
                              )
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedBottomMenu = currentDataIndex;
                              });
                            },
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
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> dataBottomMenu() {
    return [
      {
        "index": 0,
        "title": "Home",
        "on": "assets/Icons/home-on.png",
        "off": "assets/Icons/home-off.png"
      },
      {
        "index": 1,
        "title": "Favorite",
        "on": "assets/Icons/favorite-on.png",
        "off": "assets/Icons/favorite-off.png"
      },
      {
        "index": 2,
        "title": "Cart",
        "on": "assets/Icons/cart-on.png",
        "off": "assets/Icons/cart-off.png"
      },
      {
        "index": 3,
        "title": "Profile",
        "on": "assets/Icons/profile-on.png",
        "off": "assets/Icons/profile-off.png"
      },
    ];
  }

}