import 'package:flutter/material.dart';
import 'utils/constants.dart';

const List<String> list = <String>['Freshman', 'Sophmore', 'Junior', 'Senior'];

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                        DropdownMenuExample(),
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
                          onTap: () {},
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
                            //TODO: Navigate to the Home Page
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
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

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
