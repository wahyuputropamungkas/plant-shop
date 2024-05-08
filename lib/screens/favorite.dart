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
  Widget displayWidget = Container();

  Future<String> addDummyDocument() async {
    String documentId = "";
    CollectionReference dummy = FirebaseFirestore.instance.collection('dummy');

    await dummy.add({
      "name": "Del Piero",
      "birthDate": "1974-11-04",
      "birthPlace": "Conegliano",
      "position": "Second Striker"
    }).then((value) {
      documentId = value.id;

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

    return documentId;
  }

  Future<Widget> displayInsertedDummyDocument({required String documentId}) async {
    CollectionReference dummy = FirebaseFirestore.instance.collection('dummy');

    return FutureBuilder(
      future: dummy.doc(documentId).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError) {
            return Center(
              child: Text(
                "Somethind went wrong. Error : ${snapshot.error.toString()}"
              ),
            );
          }

          if(snapshot.hasData && !snapshot.data!.exists) {
            return const Center(
              child: Text(
                "Document does not exist"
              ),
            );
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Column(
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        displayWidget,
        ButtonGreen(
          text: "Create dummy data",
          onTap: () async {
            await addDummyDocument().then((value) async {
              Widget widget = await displayInsertedDummyDocument(documentId: value);
              if(value != "") {
                setState(() {
                  displayWidget = widget;
                });
              }
            });
          },
        )
      ],
    );
  }

}