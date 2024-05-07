import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantshop/components/buttons/button_green.dart';

class Favorite extends StatefulWidget {

  const Favorite({super.key});

  @override
  State<Favorite> createState() => _Favorite();

}

class _Favorite extends State<Favorite> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addDummyDocument() async {
    CollectionReference dummy = FirebaseFirestore.instance.collection('dummy');

    await dummy.add({
      "name": "Del Piero",
      "birthDate": "1974-11-04",
      "birthPlace": "Conegliano",
      "position": "Second Striker"
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Dummy data added"
          ),
        )
      );
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Failed to create dummy data. Error : ${error.toString()}"
            ),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonGreen(
          text: "Create dummy data",
          onTap: () async {
            addDummyDocument();
          },
        )
      ],
    );
  }

}