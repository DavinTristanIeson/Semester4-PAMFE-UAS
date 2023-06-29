import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/components/wrapper/touchable.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/helpers/validators.dart';
import 'package:memoir/views/login/components.dart';

GlobalKey<FormBuilderState> _loginFormKey = GlobalKey();

class LoginForm extends StatelessWidget {
  final void Function() onSwitch;
  const LoginForm({super.key, required this.onSwitch});

  void submit() {
    if (_loginFormKey.currentState == null)
      throw Exception(
          "Cannot find login form in the Widget tree. Did you forget to put the key into the login form?");
    final FormBuilderState state = _loginFormKey.currentState!;
    if (!state.validate()) return;
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
          Padding(
            padding: const EdgeInsets.only(top: GAP_LG, bottom: GAP),
            child: ElevatedButton(
              onPressed: submit,
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
