import 'package:flutter/material.dart';

class NameOne{
  String name;

  NameOne({
    required this.name,
  });
  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json){
    return NameOne(
        name: json["name"],
    );
  }
}