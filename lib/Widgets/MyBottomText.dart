import 'package:flutter/material.dart';

Widget myBottomText(String firstText, String secondText,){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(firstText),
      SizedBox(width: 5.0),
      GestureDetector(
        child: Text(secondText,style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
        onTap: (){},
      )
    ],
  );
}