import 'package:flutter/material.dart';

class ColorConstant {
  ColorConstant._();

  static const back = Color(0xFF474747);

  static const accent = Color(0xFF74AA9C);
  static const accent2 = Color(0xFFEBFFFA);
  static const main = Color(0xFFFFFFFF);
  static const text = Color(0xFFFFFFFF);

  static const chat1 = Color(0xFFFF7D34);
  static const chat2 = Color(0xFF74AA9C);
  static const chat3 = Color(0xFFA58CEA);
  static const chat4 = Color(0xFF23ACD8);
  static const chat5 = Color(0xFFFFC03F);

  static const black100 = Color(0xFFFFFFFF);
  static const black99 = Color(0xFFFAFAFA);
  static const black95 = Color(0xFFF4F4F4);
  static const black90 = Color(0xFFE6E6E6);
  static const black80 = Color(0xFFC9C9C9);
  static const black70 = Color(0xFFAEAEAE);
  static const black60 = Color(0xFF939393);
  static const black50 = Color(0xFF787878);
  static const black40 = Color(0xFF606060);
  static const black30 = Color(0xFF484848);
  static const black20 = Color(0xFF313131);
  static const black10 = Color(0xFF1C1C1C);
  static const black0 = Color(0xFF000000);
}

Color getChatColor(int assignedId) {
  switch(assignedId) {
    case 1:
      return ColorConstant.chat1;
    case 2:
      return ColorConstant.chat2;
    case 3:
      return ColorConstant.chat3;
    case 4:
      return ColorConstant.chat4;
    case 5:
      return ColorConstant.chat5;
    default:
      return ColorConstant.black100;
  }
}