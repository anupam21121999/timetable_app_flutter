import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/data.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  void saveData() {
    String name = nameController.text.trim();
    String details = detailsController.text.trim();

    nameController.clear();
    detailsController.clear();

    if (name != '' && details != '') {
      Map<String, dynamic> userData = {
        "name": name,
        "details": details
      };
      FirebaseFirestore.instance.collection("timetable").add(userData);
    }
    else {
      log("fill the details");
    }
  }

  @override
  Widget build(BuildContext context) {

    List<NameOne> namelist = [];
    namelist.add(NameOne(name:"Name 1"));
    namelist.add(NameOne(name:"Name 1"));
    namelist.add(NameOne(name:"Name 1"));

    return Scaffold(
      appBar: AppBar(),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(15),
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Subject Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          )
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: detailsController,
                      decoration: InputDecoration(
                          hintText: "Subject Details",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {
                        saveData();
                      }, child: Text("SAVE")),

                    ],
                  ),
                  SizedBox(height: 10,),

                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('timetable')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.active) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> userMap = snapshot.data!
                                        .docs[index].data() as Map<String, dynamic>;

                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(userMap["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                          Text(userMap["details"]),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: 70,
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  var docId = snapshot.data!.docs[index].id;
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection("timetable").doc(
                                                        docId).update({
                                                      "nameController.text": nameController.text,
                                                      "details": detailsController.text,
                                                    });
                                                  });
                                                  nameController.clear();
                                                  detailsController.clear();
                                                },
                                                child: Icon(Icons.edit)),
                                            SizedBox(width: 10,),
                                            InkWell(
                                                onTap: () {
                                                  var docId = snapshot.data!.docs[index].id;
                                                  FirebaseFirestore.instance.collection("timetable").doc(docId).delete();
                                                },
                                                child: Icon(Icons.delete)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                          else {
                            return const Text("No Data!");
                          }
                        }
                        else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  ),
                ],
              )
          ),
        )
    );
  }
}
