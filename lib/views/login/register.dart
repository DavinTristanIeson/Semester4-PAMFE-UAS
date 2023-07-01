import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:memoir/components/display/info.dart';
import 'package:memoir/components/wrapper/input.dart';
import 'package:memoir/components/wrapper/touchable.dart';
import 'package:memoir/controller/account.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';
import 'package:memoir/helpers/validators.dart';
import 'package:memoir/views/login/components.dart';
import 'package:provider/provider.dart';

import '../../controller/common.dart';
import '../../models/account.dart';
import '../../models/app.dart';
import '../../models/common.dart';

GlobalKey<FormBuilderState> _registerFormKey = GlobalKey();

class RegisterForm extends StatelessWidget with SnackbarMessenger {
  final void Function() onSwitch;
  const RegisterForm({super.key, required this.onSwitch});

  Future<void> submit(BuildContext context) async {
    if (_registerFormKey.currentState == null) {
      throw Exception(
          "Cannot find register form in the Widget tree. Did you forget to put the key into the register form?");
    }
    final FormBuilderState state = _registerFormKey.currentState!;
    if (!state.validate()) return;

    if (!AccountController.canRegister(state.fields["email"]!.value)) {
      sendError(context, "Another account already exists with the same email");
      return;
    }

    Account account = Account(
      email: state.fields["email"]!.value,
      password: Account.hash(state.fields["password"]!.value).toString(),
      name: state.fields["name"]!.value,
      birthdate: state.fields["birthdate"]!.value,
      bio: state.fields["bio"]!.value,
      pfp: state.fields["pfp"]!.value.path,
    );
    final appState = context.read<AppStateProvider>();
    try {
      AccountController.register(account);
    } on UserException catch (e) {
      sendError(context, e.message);
      return;
    }

    account.pfp = (await saveImage(state.fields["pfp"]!.value)).path;
    appState.account = account;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _registerFormKey,
        child: LoginPageFormContainer(
          child: Column(children: [
            const TextInputField(
                name: "email",
                validator: validateEmail,
                label: "Email",
                placeholder: "Enter your email"),
            const TextInputField(
                name: "password",
                validator: validatePassword,
                label: "Password",
                obscureText: true,
                placeholder: "Enter your password"),
            const TextInputField(
                name: "name",
                validator: validateName,
                label: "Name",
                placeholder: "Enter your name"),
            const TextInputField(
              name: "bio",
              validator: noValidate,
              label: "Biography",
              placeholder: "About You",
            ),
            const DateTimeInputField(
                name: "birthdate",
                label: "Date of Birth",
                validator: noValidate,
                placeholder: "Enter your date of birth"),
            ImageInputField(
              name: "pfp",
              label: "Profile Picture",
              height: 300,
              placeholder: "Choose your profile picture",
              validator: noValidate,
            ),
            Padding(
              padding: const EdgeInsets.only(top: GAP_LG, bottom: GAP),
              child: ElevatedButton(
                onPressed: () => submit(context),
                style: BUTTON_PRIMARY,
                child: const Text("Register"),
              ),
            ),
            Row(
              children: [
                const Text("Already have an account?", style: TEXT_DETAIL),
                TextLink(onPressed: onSwitch, text: "Login")
              ],
            )
          ]),
        ));
  }
}
