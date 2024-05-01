import 'package:flutter/material.dart';
import 'package:plantshop/screens/dashboard.dart';
import 'package:plantshop/screens/login.dart';

class SplashScreen extends StatefulWidget {
  
  State<SplashScreen> createState() => _SplashScreen();
  
}

class _SplashScreen extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 5)).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login()
          )
        );
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset("assets/Images/splash.png", scale: 1, fit: BoxFit.fill),
              Center(
                child: Image.asset("assets/Logos/logo-white.png", scale: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}