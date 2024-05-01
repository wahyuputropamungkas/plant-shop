import 'package:flutter/material.dart';

class Cart extends StatefulWidget {

  const Cart({super.key});

  @override
  State<Cart> createState() => _Cart();

}

class _Cart extends State<Cart> {

  @override
  Widget build(BuildContext context) {
    return const Text(
        "Cart"
    );
  }

}