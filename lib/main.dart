import 'package:flutter/material.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/models/app.dart';
import 'package:memoir/views/login/main.dart';
import 'package:memoir/views/main.dart';
import 'package:provider/provider.dart';

import 'controller/common.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeStore();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppStateProvider()),
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: COLOR_PRIMARY,
          fontFamily: "Inter",
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: COLOR_PRIMARY,
            foregroundColor: COLOR_SECONDARY,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: COLOR_PRIMARY,
              selectedItemColor: Colors.white,
              selectedLabelStyle: TextStyle(
                fontSize: FS_DEFAULT,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: FS_DEFAULT - 2,
              )),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: COLOR_PRIMARY,
          )),
      home: appState.account == null
          ? const LoginPage()
          : ChangeNotifierProvider(
              create: (context) => SearchProvider(), child: const MainPage()),
    );
  }
}
