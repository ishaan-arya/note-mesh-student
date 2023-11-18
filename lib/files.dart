import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:note_mesh/utils/constants.dart';

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
              padding: EdgeInsets.all(20),
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

void _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);
  } else {
    // User canceled the picker
  }
}
