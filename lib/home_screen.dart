import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Timetable Management App"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(

                    // Initial Value
                    value: dropdownvalue1,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items1.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue1 = newValue!;
                      });
                    },
                  ),

                  DropdownButton(

                    // Initial Value
                    value: dropdownvalue2,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items2.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue2 = newValue!;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 30,
              ),

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
                        return DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Monday',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Tuesday',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Wednesday',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: const <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Physics'), ),
                                DataCell(Text('Chemistry')),
                                DataCell(Text('Mathematics')),
                              ],
                            ),
                          ],
                        );



                        //   Expanded(
                        //   child: ListView.builder(
                        //       itemCount: snapshot.data!.docs.length,
                        //       itemBuilder: (context, index) {
                        //         Map<String, dynamic> userMap = snapshot.data!
                        //             .docs[index].data() as Map<String, dynamic>;
                        //
                        //         return ListTile(
                        //           title: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(userMap["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                        //               Text(userMap["details"]),
                        //             ],
                        //           ),
                        //           trailing: SizedBox(
                        //             width: 70,
                        //             child: Row(
                        //               children: [
                        //                 InkWell(
                        //                     onTap: () {
                        //                       var docId = snapshot.data!.docs[index].id;
                        //                       setState(() {
                        //                         FirebaseFirestore.instance
                        //                             .collection("timetable").doc(
                        //                             docId).update({
                        //                           "nameController.text": nameController.text,
                        //                           "details": detailsController.text,
                        //                         });
                        //                       });
                        //                       nameController.clear();
                        //                       detailsController.clear();
                        //                     },
                        //                     child: Icon(Icons.edit)),
                        //                 SizedBox(width: 10,),
                        //                 InkWell(
                        //                     onTap: () {
                        //                       var docId = snapshot.data!.docs[index].id;
                        //                       FirebaseFirestore.instance.collection("timetable").doc(docId).delete();
                        //                     },
                        //                     child: Icon(Icons.delete)),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       }
                        //   ),
                        // );
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
          ),
        ),
      ),
    );
  }
}
