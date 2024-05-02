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
            builder: (context) => const Login()
          )
        );
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset("assets/Images/splash.png", scale: 0.5, fit: BoxFit.fitHeight),
            ),
            Center(
              child: Image.asset("assets/Logos/logo-white.png", scale: 3),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: const Center(
                  child: Text(
                    "\u00a92024 Oemah Solution Indonesia",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}