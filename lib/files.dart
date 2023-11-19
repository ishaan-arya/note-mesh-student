import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:note_mesh/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:intl/intl.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Upload your Notes!",
                style: kHeadingStyle.copyWith(fontSize: 28),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: _pickFile,
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Center(
                    child: Text(
                      "Pick a File",
                      style: TextStyle(fontFamily: "RobotoMono"),
                    ),
                  ),
                  decoration: kGreenBoxDecoration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _uploadFile(File file) async {
  try {
    String nameOfClass = "ClassName"; 
    String lectureNumber = "Lecture1";
    String date = DateFormat('yyyyMMdd').format(DateTime.now());

    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = file.path.split('/').last;
    String filePath =
        'notes/$nameOfClass/$lectureNumber/${date}_${timestamp}_$fileName';
    await FirebaseStorage.instance.ref(filePath).putFile(file);
  } catch (e) {
    print('Error uploading file: $e');
  }
}

void _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
    _uploadFile(file);
  } else {
  }
}
