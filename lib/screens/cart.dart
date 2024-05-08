import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {

  const Cart({super.key});

  @override
  State<Cart> createState() => _Cart();

}

class _Cart extends State<Cart> {

  final Stream<QuerySnapshot> dummy = FirebaseFirestore.instance.collection('dummy').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dummy,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Center(
            child: Text(
                "Somethind went wrong. Error : ${snapshot.error.toString()}"
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Wrap(
          direction: Axis.vertical,
          spacing: 10,
          children: List.generate(snapshot.data!.docs.length, (index) {
            DocumentSnapshot data = snapshot.data!.docs[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      children: [
                        const TextSpan(
                            text: "Position : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            )
                        ),
                        TextSpan(
                            text: data["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400
                            )
                        )
                      ]
                  ),
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      children: [
                        const TextSpan(
                            text: "Birth date : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            )
                        ),
                        TextSpan(
                            text: data["birthDate"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400
                            )
                        )
                      ]
                  ),
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      children: [
                        const TextSpan(
                            text: "Birth place : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            )
                        ),
                        TextSpan(
                            text: data["birthPlace"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400
                            )
                        )
                      ]
                  ),
                ),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      children: [
                        const TextSpan(
                            text: "Position : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700
                            )
                        ),
                        TextSpan(
                            text: data["position"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400
                            )
                        )
                      ]
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

}