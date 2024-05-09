import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:plantshop/components/appbars/appbar_home.dart';
import 'package:plantshop/constants/custom_colors.dart';
import 'package:plantshop/screens/cart.dart';
import 'package:plantshop/screens/favorite.dart';
import 'package:plantshop/screens/home.dart';
import 'package:plantshop/screens/profile.dart';
import 'package:material_dialogs/material_dialogs.dart';

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

    askForPermissions();
  }

  void askForPermissions() async {
    if(Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt<= 32) {
        await [
          Permission.storage,
          Permission.manageExternalStorage
        ].request();
      } else {
        await [
          Permission.photos,
          Permission.manageExternalStorage
        ].request();
      }
    } else if (Platform.isIOS) {
      await [
        Permission.photos
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        // await showDialog(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: Text("Confirmation"),
        //       content: Text("Do you want to exit app?"),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //
        //           },
        //           child: Text("OK"),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //
        //           },
        //           child: Text("Cancel"),
        //         )
        //       ],
        //     );
        //   }
        // );

        await Dialogs.materialDialog(
          context: context,
          barrierDismissible: false,
          customViewPosition: CustomViewPosition.AFTER_ACTION,
          customView: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("assets/Logos/logo.png", scale: 3),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Do you want to exit app?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF222831),
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 20
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Color(0xFFC4C4C4), width: 0.5)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Color(0xFFC4C4C4), width: 0.25),
                              ),
                            ),
                            child: InkWell(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16)
                                ),
                                onTap: () {
                                  if (Platform.isAndroid) {
                                    SystemNavigator.pop();
                                  } else if (Platform.isIOS) {
                                    exit(0);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: const Text(
                                    "Yes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF222831),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Color(0xFFC4C4C4), width: 0.25),
                              ),
                            ),
                            child: InkWell(
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(16)
                                ),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: const Text(
                                    "Cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF222831),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );

        return Future.value(false);
      },
      child: Scaffold(
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
                        maintainSize: false,
                        maintainAnimation: true,
                        child: const Home(),
                      ),
                      Visibility(
                        visible: selectedBottomMenu == 1 ? true : false,
                        maintainState: true,
                        maintainSize: false,
                        maintainAnimation: true,
                        child: const Favorite(),
                      ),
                      Visibility(
                        visible: selectedBottomMenu == 2 ? true : false,
                        maintainState: true,
                        maintainSize: false,
                        maintainAnimation: true,
                        child: const Cart(),
                      ),
                      Visibility(
                        visible: selectedBottomMenu == 3 ? true : false,
                        maintainState: true,
                        maintainSize: false,
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