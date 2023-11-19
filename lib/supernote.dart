import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SuperNoteScreen extends StatefulWidget {
  int number = 0;

  SuperNoteScreen(int num) {
    number = num;
  }

  @override
  State<SuperNoteScreen> createState() => _SuperNoteScreenState();
}

class _SuperNoteScreenState extends State<SuperNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text(
          num!.toString(),
        ),
      ),
    );
  }
}
