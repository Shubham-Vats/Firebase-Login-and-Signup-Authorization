import 'package:flutter/material.dart';

Widget myButton(String _title, Function onPressed){
  return Center(
    child: RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: 100.0,vertical: 15.0),
      onPressed: (){
        onPressed();
      },
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.redAccent,
      child: Text(_title,style: TextStyle(fontSize:25.0,color: Colors.white),),
    ),
  );
}