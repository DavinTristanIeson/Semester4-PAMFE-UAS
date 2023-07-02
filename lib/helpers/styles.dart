import 'package:flutter/material.dart';

import 'constants.dart';

const VGRADIENT_PRIMARY_FADE = LinearGradient(
  colors: [COLOR_PRIMARY, Colors.white],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const VGRADIENT_APPBAR = LinearGradient(
  colors: [COLOR_PRIMARY, Color.fromARGB(255, 159, 217, 251)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
const VGRADIENT_CARD = LinearGradient(
  colors: [Colors.white, Color.fromARGB(255, 225, 245, 255)],
  stops: [0.6, 0.7],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const VGRADIENT_BOTTOM_NAVBAR = LinearGradient(
  colors: [COLOR_PRIMARY, Color.fromARGB(255, 159, 217, 251)],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
const VGRADIENT_DISABLED_FADE = LinearGradient(
  colors: [COLOR_DISABLED, Colors.white],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const SHADOW_TEXT = [
  Shadow(
      offset: Offset(4.0, 5.0),
      blurRadius: 1.5,
      color: Color.fromRGBO(0, 0, 0, 0.2))
];
const BOX_SHADOW_DEFAULT = [
  BoxShadow(
    blurRadius: 3,
    offset: Offset(2.0, 3.0),
    color: Color.fromRGBO(0, 0, 0, 0.2),
  )
];

const CIRCLE_SHAPE = CircleBorder(side: BorderSide.none);

const BORDER_INPUT = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(BR_DEFAULT)),
    borderSide: BorderSide(color: Colors.black, width: 4.0));
final BORDER_THICK = Border.all(color: Colors.black, width: 4.0);

final BUTTON_PRIMARY = ElevatedButton.styleFrom(
  backgroundColor: COLOR_PRIMARY,
  shape: const StadiumBorder(),
  textStyle: TEXT_BTN_PRIMARY,
);
final BUTTON_SUCCESS = ElevatedButton.styleFrom(
  backgroundColor: COLOR_SUCCESS,
  shape: const StadiumBorder(),
  textStyle: TEXT_BTN_PRIMARY,
);
final BUTTON_DANGER = ElevatedButton.styleFrom(
  backgroundColor: COLOR_DANGER,
  shape: const StadiumBorder(),
  textStyle: TEXT_BTN_PRIMARY,
);

const TEXT_DEFAULT = TextStyle(
  fontSize: FS_DEFAULT,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);
const TEXT_DISABLED = TextStyle(
  fontSize: FS_DEFAULT,
  color: Colors.black54,
  fontWeight: FontWeight.w400,
);
const TEXT_BTN_PRIMARY = TextStyle(
  fontSize: FS_EMPHASIS,
  color: COLOR_ON_PRIMARY,
  fontWeight: FontWeight.bold,
);
const TEXT_IMPORTANT = TextStyle(
  fontSize: FS_EMPHASIS,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);
const TEXT_DETAIL = TextStyle(
  fontSize: FS_DEFAULT,
  color: Colors.black,
  fontWeight: FontWeight.w300,
);
const TEXT_ERROR = TextStyle(
  fontSize: FS_DEFAULT,
  color: COLOR_DANGER,
  fontWeight: FontWeight.w500,
);
const TEXT_ERROR_IMPORTANT = TextStyle(
  fontSize: FS_LARGE,
  color: COLOR_DANGER,
  fontWeight: FontWeight.bold,
  shadows: SHADOW_TEXT,
);
const TEXT_SMALL_DETAIL = TextStyle(
  fontSize: FS_SMALL,
  color: COLOR_ON_PRIMARY,
  fontWeight: FontWeight.w200,
);
