import 'package:flutter/material.dart';

Widget myAppBar(String title, String subTitle){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(title, style: TextStyle(
        color: Colors.redAccent,
        fontSize: 35.0,
        fontWeight: FontWeight.w500
      ),),
      Text(subTitle, style: TextStyle(
        color: Colors.redAccent,
        fontSize: 25.0,
        fontWeight: FontWeight.w400,
      ),),
    ],
  );
}