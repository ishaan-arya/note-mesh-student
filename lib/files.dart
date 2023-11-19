import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:note_mesh/home.dart';
import 'dart:io';
import 'package:note_mesh/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({super.key});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  Future<void> _uploadFile(File file) async {
    try {
      String nameOfClass = "ClassName";
      String lectureNumber = "Lecture1";
      User? user = FirebaseAuth.instance.currentUser;

      String userName = user?.displayName ?? 'UnknownUser';
      String filePath = '$nameOfClass/$lectureNumber/student_notes/${userName}';
      await FirebaseStorage.instance.ref(filePath).putFile(file);
      setState(() {
        fileSent = true;
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  String _file_text = "Pick a File";
  bool fileSent = false;
  late File send_file;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.4,
            ),
            Center(
              child: Text(
                "Upload your Notes!",
                style: kHeadingStyle.copyWith(fontSize: 28),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Center(
                      child: Text(
                        _file_text,
                        style: TextStyle(fontFamily: "RobotoMono"),
                      ),
                    ),
                    decoration: kGreenBoxDecoration,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _uploadFile(send_file);
                },
                child: Container(
                  height: 70,
                  width: (MediaQuery.of(context).size.width * 0.3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: fileSent
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 27,
                          )
                        : Icon(
                            Icons.upload_file,
                            color: Colors.white,
                            size: 27,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _file_text = file.path;
        send_file = file;
      });
    } else {}
  }
}
