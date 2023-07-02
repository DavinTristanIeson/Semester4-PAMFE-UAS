import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class MemoirBrand extends StatelessWidget {
  const MemoirBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("MEMOIR",
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          shadows: SHADOW_TEXT,
          fontSize: FS_LARGE,
          fontWeight: FontWeight.w300,
        ));
  }
}
