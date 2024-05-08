import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantshop/components/buttons/button_green.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = FirebaseAuth.instance.currentUser;

      if(user != null) {
        setState(() {
          name = user.displayName!;
          email = user.email!;
          photoUrl = user.photoURL!;
        });
      }
    });
  }

  Future<Map<String, dynamic>> getUserFromSession() async {
    Map<String, dynamic> user = {};

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user = json.decode(sharedPreferences.getString("user")!);

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
                  snapshot.data!["user"]["email"],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700
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
        name != null ? Text(
          name,
          style: const TextStyle(
              color: Colors.black
          ),
        ) : Container(),
        email != null ? Text(
            email
        ) : Container(),
        photoUrl != null && photoUrl != "" ? Image.network(photoUrl, scale: 4) : Container(),
        Row(
          children: [
            ButtonGreen(
              onTap: () async {
                SharedPreferences sh = await SharedPreferences.getInstance();
                await sh.clear();

                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login()
                      )
                  );
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