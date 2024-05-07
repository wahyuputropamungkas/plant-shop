import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _Register();

}

class _Register extends State<Register> {

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();
  TextEditingController ctrlPassConfirm = TextEditingController();

  static final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> createUser() async {
    bool response = false;

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: ctrlEmail.text,
        password: ctrlPass.text,
      );

      response = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
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
                  title: "Crete new account",
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
                FormGroup(
                  label: "Confirm Password",
                  form: FormPassword(
                    controller: ctrlPassConfirm,
                    hintText: "Enter your confirm password",
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
                    text: "Sign Up",
                    onTap: () async {
                      if(ctrlEmail.text.isNotEmpty && ctrlPass.text.isNotEmpty && ctrlPassConfirm.text.isNotEmpty) {
                        if(ctrlPass.text == ctrlPassConfirm.text) {
                          await createUser().then((value) {
                            if(value == true) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Failed to register user"
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

                            if (kDebugMode) {
                              print(stackTrace);
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Password did not match"
                                ),
                              )
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Incomplete form"
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
                            text: "Already have an account? "
                        ),
                        TextSpan(
                            text: "Back to Sign In",
                            style: TextStyle(
                                color: CustomColors().green,
                                fontWeight: FontWeight.w600
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.pop(context);
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