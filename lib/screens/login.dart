import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plantshop/components/agreement.dart';
import 'package:plantshop/components/buttons/button_facebook.dart';
import 'package:plantshop/components/buttons/button_google.dart';
import 'package:plantshop/components/buttons/button_green.dart';
import 'package:plantshop/components/custom_page_title.dart';
import 'package:plantshop/components/forms/form_group.dart';
import 'package:plantshop/components/forms/form_password.dart';
import 'package:plantshop/components/forms/form_text.dart';
import 'package:plantshop/constants/custom_colors.dart';
import 'package:plantshop/screens/dashboard.dart';
import 'package:plantshop/screens/register.dart';
import 'package:http/http.dart' as http;
import 'package:plantshop/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _Login();

}

class _Login extends State<Login> {

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> signIn() async {
    Map<String, dynamic> response = {
      "status": false,
      "user": {
        "name": "",
        "email": ""
      }
    };

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: ctrlEmail.text,
          password: ctrlPass.text
      );

      response["status"] = true;
      response["user"] = {
        "name": credential.user!.displayName,
        "email": credential.user!.email
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Image.asset("assets/Logos/logo.png", scale: 3),
                const SizedBox(
                  height: 30,
                ),
                const CustomPageTitle(
                  title: "Sign in to your account",
                  text: "Check",
                ),
                const SizedBox(
                  height: 30,
                ),
                FormGroup(
                  label: "Email Address",
                  form: FormText(
                    controller: ctrlEmail,
                    hintText: "Enter your email address",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                FormGroup(
                  label: "Password",
                  form: FormPassword(
                    controller: ctrlPass,
                    hintText: "Enter your password",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        onTap: () {

                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: CustomColors().grey757575,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Agreement(),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonGreen(
                    text: "Sign In",
                    onTap: () async {
                      if(ctrlEmail.text.isNotEmpty && ctrlPass.text.isNotEmpty) {
                        await signIn().then((value) async {
                          if(value["status"] == true) {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            await sh.setString("user", value["user"]);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const Dashboard()
                                )
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Unable to login"
                                  ),
                                )
                            );
                          }
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Error. ${error.toString()}"
                                ),
                              )
                          );
                        });

                        // var body = json.encode({
                        //   "email": ctrlEmail.text,
                        //   "password": ctrlPass.text
                        // });
                        //
                        // await http.post(
                        //     Uri.parse("https://private-40208d-flutterworkshop.apiary-mock.com/products"),
                        //     headers: {"Content-Type": "application/json"},
                        //     body: body,
                        //     encoding: Encoding.getByName("utf-8")
                        // ).then((value) {
                        //   dynamic apiResponse = json.decode(value.body.toString());
                        //   bool status = apiResponse["status"];
                        //
                        //   if(status) {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (ctx) => const Dashboard()
                        //         )
                        //     );
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(
                        //           content: Text(
                        //               "Unable to login"
                        //           ),
                        //         )
                        //     );
                        //   }
                        // });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Field required"
                              ),
                            )
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Other way to sign",
                  style: TextStyle(
                    color: CustomColors().grey757575,
                    fontSize: 12,
                    fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Wrap(
                  direction: Axis.horizontal,
                  spacing: 10,
                  children: [
                    ButtonGoogle(),
                    ButtonFacebook()
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: CustomColors().grey757575,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Manrope"
                    ),
                    children: [
                      const TextSpan(
                        text: "Don't have an account? "
                      ),
                      TextSpan(
                        text: "Create Account",
                        style: TextStyle(
                          color: CustomColors().green,
                          fontWeight: FontWeight.w600
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const Register()
                            )
                          );
                        }
                      )
                    ]
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}