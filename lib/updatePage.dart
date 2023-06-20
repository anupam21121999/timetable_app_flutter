import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/home_screen.dart';
import 'package:timetable_app/timetable.dart';



class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  void updateData() {
    var collectionRef = FirebaseFirestore.instance.collection('timetable');
    var documentRef = collectionRef.doc('Pw4rLe0teWJaFduDEhUu'); // Replace with the actual document ID

    var newData = {
      'monday': mond,
      'tuesday': tue,
      'wednesday': wed,
      'thursday': thrus,
      'friday': fri,
    };

    documentRef.update(newData)
        .then((value) {
      print('Data updated successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    })
        .catchError((error) {
      print('Failed to update data: $error');
    });
  }

  List mond =[];
  List tue =[];
  List wed =[];
  List thrus =[];
  List fri =[];
  List time =[
    '8:50-9:50',
    '9:50-10:50',
    '10:50-11:50',
    '11:50-12:50',
    '12:50-1:50',
    '1:50-2:50',
  ];
  void fetchData() async {
    var collectionRef = FirebaseFirestore.instance.collection('timetable');
    var snapshot = await collectionRef.get();

    if (snapshot.docs.isNotEmpty) {
      // Iterate over the retrieved documents
      for (var document in snapshot.docs) {
        // Access the document data
        var data = document.data();

        for(int i=0;i<6;i++){
          setState(() {
            mond.add(data["monday"][i]);
            tue.add(data["tuesday"][i]);
            wed.add(data["wednesday"][i]);
            thrus.add(data["thursday"][i]);
            fri.add(data["friday"][i]);
            log(mond.toString());
          });
        }
        log(data.toString());
      }
    } else {
      print('No data available');
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController monController = TextEditingController();
  TextEditingController tueController = TextEditingController();
  TextEditingController wedController = TextEditingController();
  TextEditingController thruController = TextEditingController();
  TextEditingController friController = TextEditingController();



  void saveData() {
    String name = nameController.text.trim();
    String details = detailsController.text.trim();

    nameController.clear();
    detailsController.clear();

    if (mond.isNotEmpty) {
      Map<String, dynamic> userData = {
        "monday":mond,
        "tuesday":tue,
        "wednesday":wed,
        "thursday":thrus,
        "friday":fri,
        "time":time
      };
      FirebaseFirestore.instance.collection("timetable").add(userData);
      mond.clear();
      tue.clear();
      wed.clear();
      thrus.clear();
      fri.clear();
    }
    else {
      log("fill the details");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable Management App"),
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirebaseDataScreen()));
              },
              child: Icon(Icons.calendar_month))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          controller: monController,
                          decoration: InputDecoration(
                              hintText: "${mond.length} sub added for monday",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              )
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          mond.add(monController.text);
                          mond.length ==  7 ? mond.clear():'';
                          monController.clear();
                        });
                      }, child: Icon(Icons.add))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          controller: tueController,
                          decoration: InputDecoration(
                              hintText: "${tue.length} sub added for Tue",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              )
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          tue.add(tueController.text);
                          tue.length ==  7 ? tue.clear():'';
                          tueController.clear();
                        });
                      }, child: Icon(Icons.add))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          controller: wedController,
                          decoration: InputDecoration(
                              hintText: "${wed.length} sub added for monday",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              )
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          wed.add(wedController.text);
                          wed.length ==  7 ? wed.clear():'';
                          wedController.clear();
                        });
                      }, child: Icon(Icons.add))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          controller: thruController,
                          decoration: InputDecoration(
                              hintText: "${thrus.length} sub added for monday",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              )
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          thrus.add(thruController.text);
                          thrus.length ==  7 ? thrus.clear():'';
                          thruController.clear();
                        });
                      }, child: Icon(Icons.add))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width/1.5,
                        child: TextField(
                          controller: friController,
                          decoration: InputDecoration(
                              hintText: "${fri.length} sub added for monday",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )
                              )
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          fri.add(friController.text);
                          fri.length ==  7 ? fri.clear():'';
                          friController.clear();
                        });
                      }, child: Icon(Icons.add))
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {
                      updateData();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FirebaseDataScreen()));
                    }, child: Text("Update")),

                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future OpenDialog(BuildContext context,String day) => showDialog(
    barrierColor: Colors.black38,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.indigo.shade50,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // height:600,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Column(
                  children: [
               Text("Are you sure want to edit $day"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("Yes")),
                        ElevatedButton(onPressed: (){}, child: Text("No"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: -35,
              child: CircleAvatar(
                child: Icon(
                  Icons.ac_unit_sharp,
                  size: 40,
                ),
                radius: 40,
              )),
        ],
      ),
    ),
  );
}