import 'package:flutter/material.dart';
import 'package:memoir/components/display/text.dart';
import 'package:memoir/components/wrapper/gradient.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/models/app.dart';
import 'package:memoir/views/browse/main.dart';
import 'package:memoir/views/mine/main.dart';
import 'package:memoir/views/mine/scaffold.dart';
import 'package:memoir/views/profile/changepassword.dart';
import 'package:memoir/views/profile/editprofile.dart';
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
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Widget buildSearchInput(BuildContext context) {
    final provider = context.read<SearchProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: GAP_LG),
      child: Focus(
        onFocusChange: (isFocused) {
          if (!isFocused) {
            provider.search = _search.text;
          }
        },
        child: TextField(
          controller: _search,
          decoration: const InputDecoration(
              filled: true, fillColor: COLOR_SECONDARY, hintText: "Search"),
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return AppBarGradient(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const MemoirBrand(),
            if (page != MainPageView.Profile) buildSearchInput(context),
          ],
        ),
        actions: [
          if (page == MainPageView.Profile)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                showLogoutConfirmationDialog(context);
              },
            ),
          if (page == MainPageView.Profile)
            PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) {
                if (value == 'edit_profile') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EditProfileForm(
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                } else if (value == 'change_password') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ChangePasswordPage()));
                } else if (value == 'delete_account') {
                  // ProfilePage profilePage = const ProfilePage();
                  // profilePage.confirmDelete(context);
                }
              },
              constraints: const BoxConstraints.tightFor(width: 220),
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit_profile',
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      size: 14,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'change_password',
                  child: ListTile(
                    leading: Icon(
                      Icons.lock,
                      size: 14,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Change Password',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete_account',
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      size: 14,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    final provider = context.read<SearchProvider>();
    return BottomNavigationBarGradient(
      child: BottomNavigationBar(
        onTap: (select) {
          setState(() {
            page = MainPageView.values[select];
            provider.search = "";
            _search.text = "";
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
        return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildView(),
      bottomNavigationBar: buildBottomNavBar(context),
      floatingActionButton:
          page == MainPageView.MyFlashcards ? const CreateFlashcardFAB() : null,
    );
  }
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              final appStateProvider =
                  Provider.of<AppStateProvider>(context, listen: false);
              Navigator.of(context).pop();
              appStateProvider.logout();
            },
          ),
        ],
      );
    },
  );
}
