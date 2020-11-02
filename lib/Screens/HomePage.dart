import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            myAppBar("Welcome", "Congratulations You!!"),
            SizedBox(height:50.0),
            Container(
              width: 150,
              height: 60,
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.redAccent,
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.logout,color: Colors.white,),
                    SizedBox(width:5.0),
                    Text("LogOut",style: TextStyle(color: Colors.white, fontSize: 18.0),)
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}