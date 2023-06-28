import 'package:flutter/material.dart';

import 'main.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => LoginPage.of(context).setMode(true),
        child: const Text("Login"));
  }
}
