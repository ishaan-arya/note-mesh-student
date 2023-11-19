import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore

const List<String> list = <String>['Freshman', 'Sophomore', 'Junior', 'Senior'];

class SignUpScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<_DropdownMenuExampleState> _dropdownKey = GlobalKey();

  Future<void> _registerUser(BuildContext context) async {
    final String name = _nameController.text.trim();
    final String major = _majorController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String year = _dropdownKey.currentState?.dropdownValue ?? '';
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

    if (name.isEmpty ||
        major.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        year.isEmpty) {
      showErrorDialog(context, "Error: Please fill out all fields.");
      return;
    }

    try {
      // Create user in Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional information in Firestore
      FirebaseFirestore.instance
          .collection('Students')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'major': major,
        'year': year,
      });
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth errors here
      print('Firebase Auth Error: ${e.message}');
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
                  "Sign Up",
                  style: kHeadingStyle,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
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
                          "Name",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          "Year",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        DropdownMenuExample(
                            key: _dropdownKey, initialValue: list.first),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          "Major",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextField(
                          controller: _majorController,
                          decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: kTextFieldDecoration.copyWith(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          "Password",
                          style: TextStyle(fontFamily: "RobotoMono"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
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
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Already have an account? Log in",
                            style: TextStyle(
                                fontFamily: "RobotoMono", fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registerUser(context);
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
    ;
  }
}

class DropdownMenuExample extends StatefulWidget {
  final String initialValue;

  const DropdownMenuExample({Key? key, required this.initialValue})
      : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.75) - 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
          ),
          elevation: 16,
          style: const TextStyle(fontFamily: "RobotoMono", color: Colors.black),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
