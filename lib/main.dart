import 'package:flutter/material.dart';
import 'package:memoir/views/login/main.dart';

void main() {
  runApp(const MemoirApp());
}

class MemoirApp extends StatelessWidget {
  const MemoirApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      home: const LoginPage(),
    );
  }
}
