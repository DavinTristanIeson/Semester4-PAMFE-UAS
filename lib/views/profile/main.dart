import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/models/common.dart';
import 'package:provider/provider.dart';

import '../../helpers/constants.dart';
import '../../models/app.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SnackbarMessenger {
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.of(context).pop();
                _checkPasswordDeleteAcc(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _checkPasswordDeleteAcc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Check Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    String password = _passwordController.text.trim();
                    if (password.isEmpty) {
                      setState(() {
                        _errorText = 'Password is required';
                      });
                      return;
                    }

                    AppStateProvider appStateProvider =
                        Provider.of<AppStateProvider>(context, listen: false);
                    try {
                      appStateProvider.deleteAccount(password);
                      Navigator.of(context).pop();
                      appStateProvider.logout();
                      sendSuccess(context,
                          "Account ${appStateProvider.account!.name} has been successfully deleted");
                    } on UserException catch (e) {
                      setState(() {
                        _errorText = e.message;
                        _passwordController.clear();
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AppStateProvider>(context).account;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: account?.image != null
                          ? FileImage(account!.image!)
                          : null,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account!.name,
                            style: const TextStyle(fontSize: 30),
                          ),
                          const Divider(color: COLOR_LINK),
                          Text(
                            account.email,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36.0),
                const Row(
                  children: [
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 260.0,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      account.bio ?? '',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 36.0),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 12.0,
          //   left: 12.0,
          //   child: Container(
          //     padding: const EdgeInsets.all(8.0),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //     child: ElevatedButton.icon(
          //       onPressed: () {
          //         confirmDelete(context);
          //       },
          //       icon: const Icon(Icons.delete),
          //       label: const Text("Delete Account"),
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.red,
          //         padding: const EdgeInsets.all(16.0),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
