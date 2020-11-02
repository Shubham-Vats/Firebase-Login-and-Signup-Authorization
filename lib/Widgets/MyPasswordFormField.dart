import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPaswordFormField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;

  const MyPaswordFormField({Key key, @required this.hintText, @required this.controller}) : super(key: key);

  
  @override
  _MyPaswordFormFieldState createState() => _MyPaswordFormFieldState();
}

class _MyPaswordFormFieldState extends State<MyPaswordFormField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
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
          obscureText: obscureText,
          controller: widget.controller,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              child: Icon(obscureText == true ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
              onTap: (){
                setState(() {
                  obscureText=!obscureText;
                });
              },
            ),
            hintText: widget.hintText,
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
}
