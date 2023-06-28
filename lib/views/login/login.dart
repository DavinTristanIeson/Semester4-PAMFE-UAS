import 'package:flutter/material.dart';
import 'package:memoir/helpers/constants.dart';
import 'package:memoir/helpers/styles.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(gradient: VERTICAL_FADING_GRADIENT),
            child: Column(
              children: [
                const Text("MEMOIR",
                    style: TextStyle(
                      color: COLOR_FADED_75,
                      fontSize: FS_LARGE,
                      shadows: TEXT_SHADOW,
                    )),
                Container(
                    decoration: const BoxDecoration(
                        color: COLOR_FADED_25,
                        borderRadius:
                            BorderRadius.all(Radius.circular(BR_BIG))),
                    child: const Column(
                      children: [],
                    )),
              ],
            )));
  }
}
