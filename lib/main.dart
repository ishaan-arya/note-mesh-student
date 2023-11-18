import 'package:flutter/material.dart';
import 'files.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginScreen(),
        // '/files': (context) => FileScreen(),
      },
      initialRoute: '/',
    );
  }
}
