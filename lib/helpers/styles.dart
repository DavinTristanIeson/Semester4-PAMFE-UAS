import 'package:flutter/material.dart';

import 'constants.dart';

const VGRADIENT_PRIMARY_FADE = LinearGradient(
  colors: [COLOR_PRIMARY, Colors.white],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
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
    offset: Offset(4.0, 5.0),
    color: Color.fromRGBO(0, 0, 0, 0.2),
  )
];

const CIRCLE_SHAPE = CircleBorder(side: BorderSide.none);
final ELLIPTICAL_SHAPE =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(BR_LARGE));

const BORDER_INPUT = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(BR_DEFAULT)),
    borderSide: BorderSide(color: Colors.black, width: 4.0));

final BUTTON_PRIMARY = ElevatedButton.styleFrom(
    backgroundColor: COLOR_PRIMARY,
    shape: ELLIPTICAL_SHAPE,
    textStyle: TEXT_BTN_PRIMARY,
    padding:
        const EdgeInsets.symmetric(vertical: GAP_LG, horizontal: GAP_XL * 2));

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
