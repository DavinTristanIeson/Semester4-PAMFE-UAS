import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/components/wrapper/touchable.dart';
import 'package:memoir/controller/account.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/helpers/validators.dart';
import 'package:memoir/components/display/background.dart';
import 'package:provider/provider.dart';

import '../../models/account.dart';
import '../../models/app.dart';
import '../../models/common.dart';

GlobalKey<FormBuilderState> _editProfileFormKey = GlobalKey();

class EditProfileForm extends StatelessWidget with SnackbarMessenger {
  final void Function() onCancel;

  const EditProfileForm({Key? key, required this.onCancel}) : super(key: key);
  void showTransparentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const TransparentDialog(
          icon: Icons.check_circle,
          text: 'Profile updated successfully',
        );
      },
    );
  }

  Future<void> submit(BuildContext context) async {
    if (_editProfileFormKey.currentState == null) {
      throw Exception(
          "Cannot find edit profile form in the Widget tree. Did you forget to put the key into the edit profile form?");
    }
    final FormBuilderState state = _editProfileFormKey.currentState!;
    if (!state.validate()) return;

    Account account = context.read<AppStateProvider>().account!;
    account.email = state.fields["email"]!.value;
    account.name = state.fields["name"]!.value;
    account.birthdate = state.fields["birthdate"]!.value;
    account.bio = state.fields["bio"]!.value;
    XFile? profilePicture = state.fields["pfp"]!.value;
    if (profilePicture != null) {
      File profilePictureFile = File(profilePicture.path);
      account.pfp = profilePictureFile.path;
    }

    try {
      AccountController.update(account);
    } on UserException catch (e) {
      sendError(context, e.message);
      return;
    }

    context.read<AppStateProvider>().account = account;
    showTransparentDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    Account account = context.watch<AppStateProvider>().account!;
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _editProfileFormKey,
          initialValue: {
            "email": account.email,
            "name": account.name,
            "birthdate": account.birthdate,
            "bio": account.bio,
            "pfp": null,
          },
          child: LoginPageFormContainer(
            child: Column(
              children: [
                const TextInputField(
                  name: "email",
                  validator: validateEmail,
                  label: "Email",
                  placeholder: "Enter your email",
                ),
                const TextInputField(
                  name: "name",
                  validator: validateName,
                  label: "Name",
                  placeholder: "Enter your name",
                ),
                const DateTimeInputField(
                  name: "birthdate",
                  label: "Date of Birth",
                  validator: noValidate,
                  placeholder: "Enter your date of birth",
                ),
                const TextInputField(
                  name: "bio",
                  validator: noValidate,
                  label: "Biography",
                  placeholder: "About You",
                ),
                ImageInputField(
                  name: "pfp",
                  label: "Profile Picture",
                  height: 280,
                  placeholder: "Choose your profile picture",
                  validator: noValidate,
                ),
                Container(
                  width: double.maxFinite,
                  height: 64.0,
                  padding: const EdgeInsets.only(top: GAP_LG, bottom: GAP),
                  child: ElevatedButton(
                    onPressed: () {
                      submit(context);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      });
                    },
                    style: BUTTON_PRIMARY,
                    child: const Text("Save"),
                  ),
                ),
                Row(
                  children: [
                    const Text("Cancel editing?", style: TEXT_DETAIL),
                    TextLink(
                      onPressed: onCancel,
                      text: "Go back",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransparentDialog extends StatelessWidget {
  final IconData icon;
  final String text;

  const TransparentDialog({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.green,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
