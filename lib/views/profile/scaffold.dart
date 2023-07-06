import 'package:flutter/material.dart';
import 'package:memoir/components/display/info.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../../models/app.dart';
import '../../models/common.dart';
import 'changepassword.dart';
import 'editprofile.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog>
    with SnackbarMessenger {
  final TextEditingController _passwordController = TextEditingController();
  bool isDeleting = false;
  String _errorText = "";
  Widget buildCheckPasswordDialog(BuildContext context) {
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
            Account account = appStateProvider.account!;
            try {
              appStateProvider.deleteAccount(password);
              Navigator.of(context).pop();
              sendSuccess(context,
                  "Account ${account.name} has been successfully deleted");
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
  }

  @override
  Widget build(BuildContext context) {
    return isDeleting
        ? buildCheckPasswordDialog(context)
        : buildDeleteConfirmationDialog(context);
  }

  AlertDialog buildDeleteConfirmationDialog(BuildContext context) {
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
            setState(() {
              isDeleting = true;
            });
          },
        ),
      ],
    );
  }
}

class ProfileViewActions extends StatelessWidget {
  const ProfileViewActions({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ChangePasswordPage()));
        } else if (value == 'delete_account') {
          showDialog(
              context: context,
              builder: (context) => const DeleteAccountDialog());
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
    );
  }
}
