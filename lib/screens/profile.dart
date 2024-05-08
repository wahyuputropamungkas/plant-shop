import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              text: "Sign Out",
            )
          ],
        )
      ],
    );
  }

}