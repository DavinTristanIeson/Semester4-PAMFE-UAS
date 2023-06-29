import 'package:flutter/material.dart';
import 'package:memoir/helpers/constants.dart';
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
        primaryColor: COLOR_PRIMARY,
        fontFamily: "Inter",
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}
