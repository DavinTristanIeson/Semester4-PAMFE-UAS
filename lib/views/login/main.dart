import 'package:flutter/material.dart';
import 'package:memoir/views/login/login.dart';
import 'package:memoir/views/login/register.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';
import 'components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  void onSwitch() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginPageGradientBackground(
            paddingTop: isLogin ? GAP_XL * 2 : GAP_XL,
            child: Column(
              children: [
                const Text("MEMOIR",
                    style: TextStyle(
                      color: COLOR_FADED_75,
                      fontSize: FS_DISPLAY,
                      shadows: SHADOW_TEXT,
                    )),
                const SizedBox(height: GAP_XL),
                isLogin
                    ? LoginForm(
                        onSwitch: onSwitch,
                      )
                    : RegisterForm(
                        onSwitch: onSwitch,
                      ),
              ],
            )));
  }
}
