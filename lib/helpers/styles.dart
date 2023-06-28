import 'package:flutter/material.dart';

import 'constants.dart';

const VERTICAL_FADING_GRADIENT = LinearGradient(
  colors: [COLOR_PRIMARY, Colors.white],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const TEXT_SHADOW = [
  Shadow(
      offset: Offset(4.0, 5.0),
      blurRadius: 1.5,
      color: Color.fromRGBO(0, 0, 0, 0.2))
];
