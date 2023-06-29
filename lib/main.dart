import 'package:flutter/material.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/models/account.dart';
import 'package:memoir/models/app.dart';
import 'package:memoir/views/login/main.dart';
import 'package:memoir/views/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppStateProvider()),
    ChangeNotifierProvider(create: (context) => AccountCollection()),
  ], child: const MemoirApp()));
}

class MemoirApp extends StatelessWidget {
  const MemoirApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: COLOR_PRIMARY,
        fontFamily: "Inter",
        scaffoldBackgroundColor: Colors.white,
      ),
      home: appState.account == null ? const LoginPage() : const MainPage(),
    );
  }
}
