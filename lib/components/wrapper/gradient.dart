import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class AppBarGradient extends StatelessWidget implements PreferredSize {
  @override
  final AppBar child;
  const AppBarGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(BR_LARGE),
                  bottomRight: Radius.circular(BR_LARGE),
                ),
                gradient: VGRADIENT_APPBAR),
            child: child));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BottomNavigationBarGradient extends StatelessWidget {
  final BottomNavigationBar child;
  const BottomNavigationBarGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BR_LARGE),
          topRight: Radius.circular(BR_LARGE),
        ),
        gradient: VGRADIENT_BOTTOM_NAVBAR,
      ),
      child: child,
    );
  }
}
