import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'HomePage.dart';
import 'SignUpScreen.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyAppBar.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyTextFormField.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyPasswordFormField.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyButton.dart';
import 'package:FirebaseLoginAndSignUpAuthentication/Widgets/MyBottomText.dart';


TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

bool isLoading = false;
UserCredential authResult;
var errorMessage;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  void validation(){
    if(email.text.isEmpty && password.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Both the fields are Empty")
      ));
    }
    else if(email.text.isEmpty){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Email is Empty")
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
    else if(!regExp.hasMatch(email.text)){
      scaffold.currentState.showSnackBar(SnackBar(
        content: Text("Email is not Valid")
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
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials! ';
      if(err.message != null)
      {
        message = err.message.toString();
        setState(() {
          errorMessage = message.toString();
        });
      }
      scaffold.currentState.showSnackBar(SnackBar(content: Text(message.toString())));
      setState(() {
        isLoading = false;
      });
    }catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
      scaffold.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
      setState(() {
          isLoading = false;
      });
    }
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
                myAppBar("Login","Welcome Back!"),
                SizedBox(height: 100.0,),
                myTextFormField("E-Mail",email),
                MyPaswordFormField(hintText: "Password", controller: password),
                SizedBox(height: 50.0,),
                isLoading == false ? myButton("Login",validation) : Center(child: CircularProgressIndicator(),),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: myBottomText("Don't Have an Account?", "SignUp"),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
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