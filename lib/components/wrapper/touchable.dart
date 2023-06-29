import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class TextLink extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const TextLink({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(
              color: COLOR_LINK,
              fontSize: FS_DEFAULT,
              fontWeight: FontWeight.w300,
            )));
  }
}

class OverInkwell extends StatelessWidget {
  final Widget child;
  final Color? splashColor;
  final void Function()? onTap;
  const OverInkwell(
      {super.key, required this.child, this.splashColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: splashColor ?? COLOR_SECONDARY,
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
