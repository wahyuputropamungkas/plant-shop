import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:plantshop/components/buttons/button_green.dart';
import 'package:pdf/widgets.dart' as pw;

class Favorite extends StatefulWidget {

  const Favorite({super.key});

  @override
  State<Favorite> createState() => _Favorite();

}

class _Favorite extends State<Favorite> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> plants = FirebaseFirestore.instance.collection('plants').snapshots();
  Widget displayWidget = Container();
  Widget pdfFileWidget = Container();

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
        ),
        const SizedBox(
          height: 30,
        ),
        pdfFileWidget,
        const SizedBox(
          height: 30,
        ),
        StreamBuilder(
          stream: plants,
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

            return Column(
              children: [
                Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                  text: "${index + 1}. Filename: "
                              ),
                              TextSpan(
                                  text: data["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700
                                  )
                              )
                            ]
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonGreen(
                  text: "Create PDF",
                  onTap: () async {
                    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                    Random _rnd = Random();

                    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
                        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

                    final pdf = pw.Document();

                    pdf.addPage(
                        pw.Page(
                            pageFormat: PdfPageFormat.a4,
                            build: (pw.Context context) {
                              return pw.Center(
                                  child: pw.Column(
                                    children: List.generate(snapshot.data!.docs.length, (index) {
                                      DocumentSnapshot data = snapshot.data!.docs[index];

                                      return pw.Align(
                                        alignment: pw.Alignment.centerLeft,
                                        child: pw.RichText(
                                          text: pw.TextSpan(
                                              style: pw.TextStyle(
                                                color: PdfColor.fromInt(0xFF000000),
                                                fontSize: 14,
                                              ),
                                              children: [
                                                pw.TextSpan(
                                                    text: "${index + 1}. Filename: "
                                                ),
                                                pw.TextSpan(
                                                    text: data["name"],
                                                    style: pw.TextStyle(
                                                        fontWeight: pw.FontWeight.bold
                                                    )
                                                )
                                              ]
                                          ),
                                        ),
                                      );
                                    })
                                  )
                              );
                            }
                        )
                    );

                    Directory? output = (await getExternalStorageDirectories(type: StorageDirectory.downloads))?.first;

                    final file = File("${output!.path}/example_${getRandomString(5)}.pdf");

                    await file.writeAsBytes(await pdf.save()).then((value) {
                      setState(() {
                        pdfFileWidget = RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14
                              ),
                              children: [
                                TextSpan(
                                    text: "Filename : "
                                ),
                                TextSpan(
                                    text: value.path,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700
                                    )
                                )
                              ]
                          ),
                        );
                      });
                    }).onError((error, stackTrace) {
                      print(error);
                      print(stackTrace);
                    });
                  },
                )
              ],
            );
          },
        )
      ],
    );
  }

}