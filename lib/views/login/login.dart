import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/components/wrapper/touchable.dart';
import 'package:memoir/controller/account.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/helpers/validators.dart';
import 'package:memoir/components/display/background.dart';
import 'package:provider/provider.dart';

import '../../models/app.dart';
import '../../models/common.dart';

GlobalKey<FormBuilderState> _loginFormKey = GlobalKey();

class LoginForm extends StatelessWidget with SnackbarMessenger {
  final void Function() onSwitch;
  const LoginForm({super.key, required this.onSwitch});

  void submit(BuildContext context) {
    if (_loginFormKey.currentState == null) {
      throw Exception(
          "Cannot find login form in the Widget tree. Did you forget to put the key into the login form?");
    }
    final FormBuilderState state = _loginFormKey.currentState!;
    if (!state.validate()) return;

    final appState = context.read<AppStateProvider>();
    try {
      final result = AccountController.login(
          state.fields["email"]!.value, state.fields["password"]!.value);
      appState.account = result;
    } on UserException catch (e) {
      sendError(context, e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _loginFormKey,
      child: LoginPageFormContainer(
          child: Column(
        children: [
          TextInputField(
              name: "email",
              validator: isNotEmpty("Email is required"),
              label: "Email",
              placeholder: "Enter your email"),
          TextInputField(
              name: "password",
              validator: isNotEmpty("Password is required"),
              placeholder: "Enter your password",
              obscureText: true,
              label: "Password"),
          Container(
            width: double.maxFinite,
            height: 64.0,
            padding: const EdgeInsets.only(top: GAP_LG, bottom: GAP),
            child: ElevatedButton(
              onPressed: () => submit(context),
              style: BUTTON_PRIMARY,
              child: const Text("Login", style: TEXT_BTN_PRIMARY),
            ),
          ),
          Row(
            children: [
              const Text("Don't have an account yet?", style: TEXT_DETAIL),
              TextLink(onPressed: onSwitch, text: "Register")
            ],
          )
        ],
      )),
    );
  }
}
