import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_mesh/supernote.dart';
import 'package:note_mesh/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Lecture {
  int number;
  String date;
  String topic;
  Lecture({required this.number, required this.date, required this.topic});
}

class _HomeScreenState extends State<HomeScreen> {
  List<Lecture> lectures = [];

  Future<List<Lecture>> fetchLecturesFromFirestore() async {
    // Reference to the Firestore collection
    CollectionReference lecturesCollection =
        FirebaseFirestore.instance.collection('Lectures');

    // Fetch the lecture documents
    QuerySnapshot querySnapshot = await lecturesCollection.get();

    // Convert each document to a Lecture object
    List<Lecture> fetchedLectures = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Lecture(
        number: data['number'],
        date: data['date'] ?? 'Unknown Date',
        topic: data['topic'] ?? 'Unknown Topic',
      );
    }).toList();

    return fetchedLectures;
  }

  String getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    String? userName = user?.displayName ?? 'UnknownUser';
    return userName;
  }

  @override
  void initState() {
    super.initState();
    fetchLecturesFromFirestore().then((fetchedLectures) {
      setState(() {
        lectures = fetchedLectures;
        print(lectures);
      });
    });
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "My lectures",
                  style: TextStyle(fontFamily: "RobotoMono"),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lectures.length,
                itemBuilder: (context, index) {
                  return _classCard(context, lectures[index].date,
                      lectures[index].topic, lectures[index].number);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _classCard(BuildContext context, String date, String topic, int num) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new SuperNoteScreen(num),
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: kPrimaryGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date: " + date,
              style: TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Topic: " + topic,
              style: TextStyle(
                fontFamily: "RobotoMono",
                fontSize: 18,
              ),
            ),
          ],
        )),
      ),
    ),
  );
}
