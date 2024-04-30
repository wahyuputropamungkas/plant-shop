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
import 'package:plantshop/screens/dashboard.dart';
import 'package:plantshop/screens/register.dart';

class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _Login();

}

class _Login extends State<Login> {

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPass = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const Dashboard()
                          )
                      );
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