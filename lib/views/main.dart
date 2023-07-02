import 'package:flutter/material.dart';
import 'package:memoir/components/display/text.dart';
import 'package:memoir/components/wrapper/gradient.dart';
import 'package:memoir/models/app.dart';
import 'package:memoir/views/browse/main.dart';
import 'package:memoir/views/mine/main.dart';
import 'package:memoir/views/mine/scaffold.dart';
import 'package:memoir/views/profile/main.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';

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
    return AppBarGradient(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const MemoirBrand(),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBarGradient(
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
    Account account = context.watch<AppStateProvider>().account!;
    switch (page) {
      case MainPageView.Browse:
        return BrowseView(account: account);
      case MainPageView.MyFlashcards:
        return MyFlashcardsView(
          account: account,
        );
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
      floatingActionButton:
          page == MainPageView.MyFlashcards ? const CreateFlashcardFAB() : null,
    );
  }
}
