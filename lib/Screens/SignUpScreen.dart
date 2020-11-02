import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoginScreen.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyAppBar.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyTextFormField.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyPasswordFormField.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyBottomText.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyButton.dart';

GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
TextEditingController fullname = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phonenumber = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController password = TextEditingController();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

bool isLoading = false;
UserCredential authResult;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  void validation(){
    if(email.text.isEmpty && password.text.isEmpty && fullname.text.isEmpty && phonenumber.text.isEmpty && address.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("All fields are Empty")
      ));
    }
    else if(fullname.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Full Name is Empty")
      ));
    }
    else if(email.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Email is Empty")
      ));
    }
    else if(!regExp.hasMatch(email.text)){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Email is not Valid")
      ));
    }
    else if(phonenumber.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Phone Number is Empty")
      ));
    }
    else if(phonenumber.text.length < 10){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Phone Number must be of 10 characters")
      ));
    }
    else if(address.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Address is Empty")
      ));
    }
    else if(password.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Password is Empty")
      ));
    }
    else if(password.text.length < 8){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Password is too Short")
      ));
    }
    else{
      submit();
    }
  }

  void submit() async{
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    }on PlatformException catch (e) {
      String message = "Please Check Internet Connection";
      if(e.message!=null)
      {
        message = e.message.toString();
      }
      scaffold.currentState.showSnackBar(SnackBar(content: Text(message.toString())));
      setState(() {
        isLoading = false;
      });
    }catch (e) {
      setState(() {
        isLoading = false;
      });
      scaffold.currentState.showSnackBar(SnackBar(content: Text(e.toString())));
    }
    await FirebaseFirestore.instance.collection("UserData").doc(authResult.user.uid).set({
      "User Name" : fullname.text,
      "E-Mail" : email.text,
      "User Id" : authResult.user.uid,
      "Phone Number" : phonenumber.text,
      "Address" : address.text,
      "Password": password.text,
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffold,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                myAppBar("Sign Up","Create an Account!"),
                SizedBox(height: 40.0,),
                myTextFormField("Full Name",fullname),
                myTextFormField("E-Mail",email),
                myTextFormField("Phone Number",phonenumber),
                myTextFormField("Address",address),
                MyPaswordFormField(hintText: "Password", controller: password),
                SizedBox(height: 20.0,),
                isLoading == false ? myButton("Sign Up",validation) : Center(child: CircularProgressIndicator(),),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: myBottomText("Already Have an Account?", "Login"),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}