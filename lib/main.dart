import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  //to initialize firebase App
import 'package:firebase_auth/firebase_auth.dart';  //to check firebase Authorization
import 'Screens/HomePage.dart';
import 'Screens/LoginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase_Login_&_SignUp_Authentication',
      theme: ThemeData(
        primaryColor: Colors.redAccent, 
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return HomePage();
          }else{
            return LoginScreen();
          }
        },
      )
    );
  }
}