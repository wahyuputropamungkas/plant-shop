import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _Home();

}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.yellow,
    );
  }

}