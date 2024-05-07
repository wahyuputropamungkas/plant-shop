import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantshop/components/buttons/button_green.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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