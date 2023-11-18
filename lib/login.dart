import 'package:flutter/material.dart';
import 'utils/constants.dart';

class LoginScreen extends StatelessWidget {
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
                  style: TextStyle(fontFamily: "RobotoMono", fontSize: 32),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.75,
                decoration: BoxDecoration(
                  color: Color(0xffD8FFB1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 0.5,
                    ), //BoxShadow
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 35, top: 30, bottom: 15, right: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(fontFamily: "RobotoMono"),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextField(
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
                        decoration: kTextFieldDecoration.copyWith(
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
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
                          )),
                        ),
                      ),
                    ],
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
