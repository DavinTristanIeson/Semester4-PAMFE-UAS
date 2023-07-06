import 'package:flutter/material.dart';
import 'package:memoir/views/about/about.dart';

import '../../helpers/constants.dart';
import '../../helpers/styles.dart';

class MemoirBrand extends StatelessWidget {
  const MemoirBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const AboutUsPage()));
      },
      child: const Text("MEMOIR",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            shadows: SHADOW_TEXT,
            fontSize: FS_LARGE,
            fontWeight: FontWeight.w300,
          )),
    );
  }
}
