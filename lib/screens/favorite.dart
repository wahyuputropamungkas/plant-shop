import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {

  const Favorite({super.key});

  @override
  State<Favorite> createState() => _Favorite();

}

class _Favorite extends State<Favorite> {

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Favorite"
    );
  }

}