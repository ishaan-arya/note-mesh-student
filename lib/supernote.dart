import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SuperNoteScreen extends StatefulWidget {
  int number = 0;

  SuperNoteScreen(int num) {
    number = num;
  }

  @override
  State<SuperNoteScreen> createState() => _SuperNoteScreenState();
}

class _SuperNoteScreenState extends State<SuperNoteScreen> {
  late Future<File?> _pdfFile;
  Future<File?> downloadPDF(int number) async {
    final storageRef = FirebaseStorage.instance.ref();
    final supernoteDirRef = storageRef.child('Lecture$number/supernote');

    try {
      // List all items (files) inside 'supernote' directory
      ListResult results = await supernoteDirRef.listAll();

      // Check if there's at least one file
      if (results.items.isNotEmpty) {
        // Assuming you want the first file in the directory
        Reference fileRef = results.items.first;

        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/${fileRef.name}');

        // Download the file
        await fileRef.writeToFile(file);
        return file;
      } else {
        print('No files found in the directory.');
        return null;
      }
    } catch (e) {
      print('Error downloading file: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _pdfFile = downloadPDF(widget.number);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SuperNote')),
        body: FutureBuilder<File?>(
          future: _pdfFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != null) {
                return PDFView(
                  filePath: snapshot.data!.path,
                );
              } else {
                return Text('Failed to download the file.');
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
