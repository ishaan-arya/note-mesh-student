import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'utils/constants.dart'; // Ensure this file contains kTextFieldDecoration, kHeadingStyle, and kGreenBoxDecoration.
import 'dart:developer';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
        ],
      );
    },
  );
}

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    inspect(email);
    if (email.isEmpty || password.isEmpty) {
      showErrorDialog(context, "Error: Please enter an email and password.");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushReplacementNamed('/files'); 
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      showErrorDialog(context, errorMessage);
    }
  }

  @override
    Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Note Mesh",
                  style: kHeadingStyle,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: kGreenBoxDecoration,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 35, top: 30, bottom: 15, right: 35),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          obscureText: true,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(
                                fontFamily: "RobotoMono", fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.10,
                        ),
                        GestureDetector(
                          onTap: () {
                
                            signInWithEmailAndPassword(context);
                          },
                          child: Container(
                            height: 40,
                            width:
                                (MediaQuery.of(context).size.width * 0.75) - 70,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
