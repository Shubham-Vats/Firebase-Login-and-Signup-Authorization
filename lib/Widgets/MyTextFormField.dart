import 'package:flutter/material.dart';

Widget myTextFormField(String hintText, TextEditingController _controller){
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.redAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10.0),
        child: TextFormField(
          controller: _controller,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white
            ),
            border: InputBorder.none
          ),
        ),
      )
    ),
  ); 
}