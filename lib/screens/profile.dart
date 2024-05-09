import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:plantshop/components/buttons/button_green.dart';
import 'package:plantshop/models/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Profile extends StatefulWidget {

  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();

}

class _Profile extends State<Profile> {

  dynamic name = "";
  dynamic email = "";
  dynamic photoUrl = "";
  dynamic email2 = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // final user = FirebaseAuth.instance.currentUser;
      //
      // if(user != null) {
      //   setState(() {
      //     name = user.displayName!;
      //     email = user.email!;
      //     photoUrl = user.photoURL!;
      //   });
      // }
    });
  }

  Future<UserModel> getUserFromSession() async {
    UserModel user = UserModel();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.containsKey("user")) {
      user = UserModel.fromJson(json.decode(sharedPreferences.getString("user")!));
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: getUserFromSession(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasData) {
                return Text(
                  snapshot.data!.email,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                );
              }

              if(snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString()
                  ),
                );
              }

              return Container();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            ButtonGreen(
              onTap: () async {
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
                              "Do you want to sign out?",
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
                                        onTap: () async {
                                          await FirebaseAuth.instance.signOut().then((value) async {
                                            SharedPreferences sh = await SharedPreferences.getInstance();
                                            await sh.clear();

                                            if(context.mounted) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const Login()
                                                  )
                                              );
                                            }
                                          });
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
              },
              text: "Sign Out",
            )
          ],
        )
      ],
    );
  }

}