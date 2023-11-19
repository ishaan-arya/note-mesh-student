import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_mesh/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> class_list = ["EECS 281", "HISTART 392", "EECS 482"];

  String getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    String? userName = user?.displayName ?? 'UnknownUser';
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Center(
                child: Text(
                  "Hello " + getUser(),
                  style: TextStyle(fontFamily: "RobotoMono", fontSize: 26),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: class_list.length,
                itemBuilder: (context, index) {
                  return _classCard(context, class_list[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _classCard(BuildContext context, String name) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        height: 100,
        width: 200,
        color: kPrimaryGreen,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: "RobotoMono",
              fontSize: 24,
            ),
          ),
        ),
      ),
    ),
  );
}
