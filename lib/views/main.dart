import 'package:flutter/material.dart';
import 'package:memoir/views/browse/main.dart';
import 'package:memoir/views/mine/main.dart';
import 'package:memoir/views/profile/main.dart';

import '../helpers/constants.dart';
import '../helpers/styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum MainPageView {
  Browse(0),
  MyFlashcards(1),
  Profile(2);

  final int page;
  const MainPageView(this.page);
}

class _MainPageState extends State<MainPage> {
  MainPageView page = MainPageView.MyFlashcards;
  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(BR_LARGE),
              bottomRight: Radius.circular(BR_LARGE),
            ),
            gradient: VGRADIENT_APPBAR),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("MEMOIR",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                shadows: SHADOW_TEXT,
                fontSize: FS_LARGE,
                fontWeight: FontWeight.w300,
              )),
        ),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BR_LARGE),
          topRight: Radius.circular(BR_LARGE),
        ),
        gradient: VGRADIENT_BOTTOM_NAVBAR,
      ),
      child: BottomNavigationBar(
        onTap: (select) {
          setState(() {
            page = MainPageView.values[select];
          });
        },
        currentIndex: page.page,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "My Flashcards"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget buildView() {
    switch (page) {
      case MainPageView.Browse:
        return const BrowseView();
      case MainPageView.MyFlashcards:
        return const MyFlashcardsView();
      case MainPageView.Profile:
        return const ProfileView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildView(),
      bottomNavigationBar: buildBottomNavBar(),
    );
  }
}
