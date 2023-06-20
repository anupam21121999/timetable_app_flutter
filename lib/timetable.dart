import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

import 'package:timetable_app/updatePage.dart';
class FirebaseDataScreen extends StatelessWidget {


  List mond =[];
  List tue =[];
  List wed =[];
  List thrus =[];
  List fri =[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Time Table'),
        actions: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateScreen()));
              },
              child: Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('timetable').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                var data = document.data() as Map<String, dynamic>;




                // Customize how you want to display the data
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8.0,
                    color: Colors.white,
                    child: DataTable(
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columnSpacing: 0,
                        horizontalMargin: 0,

                        // columnSpacing: 10,

                        columns: [
                          DataColumn(
                            label: SizedBox(

                              child: const Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(

                              child: const Text(
                                'Mond',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(

                              child: const Text(
                                'Tue',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(

                              child: const Center(
                                  child: Text(
                                    'Wed',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(

                              child: const Center(
                                  child: Text(
                                    'Thru',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(

                              child: const Center(
                                  child: Text(
                                    'Fri',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                        ],
                        rows: List.generate(
                            6,
                                (index) => DataRow(
                              // selected: true,
                              cells: [
                                DataCell(
                                    Container(
                                      height:40,

                                      child: Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Text(
                                            data['time'][index],style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),
                                DataCell(
                                  Container(
                                    height:40,
                                    decoration: BoxDecoration(
                                      color: data["monday"][index]=="Hindi"?Colors.yellow:data["monday"][index]=="English"?Colors.blue:Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                          data['monday'][index],style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                    Container(
                                      height:40,
                                      decoration: BoxDecoration(
                                        color: data["tuesday"][index]=="English"?Colors.blue:data["tuesday"][index]=="Computer"?Colors.red:Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Text(
                                            data['tuesday'][index],style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),
                                DataCell(
                                    Container(
                                      height:40,
                                      decoration: BoxDecoration(
                                        color: data["wednesday"][index]=="Math"?Colors.grey:Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Text(
                                            data['wednesday'][index],style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),
                                DataCell(
                                    Container(
                                      height:40,
                                      decoration: BoxDecoration(
                                        color: data["thursday"][index]=="Health"?Colors.orange:Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Text(
                                            data['thursday'][index],style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),
                                DataCell(
                                    Container(
                                      height:40,
                                      decoration: BoxDecoration(
                                        color: data["friday"][index]=="Computer"?Colors.red:Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:8.0),
                                        child: Text(
                                            data['friday'][index],style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )),

                              ],
                            ))),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }

}
