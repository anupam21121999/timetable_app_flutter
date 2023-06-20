import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timetable_app/timetable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String dropdownvalue1 = 'Class 1';

  // List of items in our dropdown menu
  var items1 = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
  ];

  String dropdownvalue2 = 'Sec A';

  // List of items in our dropdown menu
  var items2 = [
    'Sec A',
    'Sec B',
    'Sec C',
    'Sec D',
  ];

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


  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController monController = TextEditingController();
  TextEditingController tueController = TextEditingController();
  TextEditingController wedController = TextEditingController();
  TextEditingController thruController = TextEditingController();
  TextEditingController friController = TextEditingController();


  void fetchData() async {
    var collectionRef = FirebaseFirestore.instance.collection('timetable');
    var snapshot = await collectionRef.get();

    if (snapshot.docs.isNotEmpty) {
      // Iterate over the retrieved documents
      for (var document in snapshot.docs) {
        // Access the document data
        var data = document.data();


        log(data.toString());
      }
    } else {
      print('No data available');
    }
  }
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
                      saveData();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FirebaseDataScreen()));
                    }, child: Text("SAVE")),

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
}
