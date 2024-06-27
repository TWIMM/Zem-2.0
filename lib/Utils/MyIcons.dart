import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String profile = "assets/icons/profile.png";
final String messages = "assets/icons/messages.png";
final String home = "assets/icons/home.png";
final String plus = "assets/icons/Plus.svg";
final String myproducts = "assets/icons/myproducts.png";
final String pp = "assets/icons/pp.png";
final String myannonce1 = "images/myannonce.png";
final String myannonce2 = "images/myannonce2.png";
final String annonce1 = "assets/icons/annonce1.png";
final String annonce2 = "assets/icons/annonce2.png";
final String setting = 'assets/icons/setting-3.svg';
final String pin = 'assets/icons/pin.svg';
final String cancel = 'assets/icons/cancel.svg';

Widget loadSvgImage(String assetPath, double width, double height) {
  return SvgPicture.asset(
    assetPath,
    width: width,
    height: height,
  );
}

class CustomIcons {
  static const IconData add_circle_sharp =
      IconData(0xe74e, fontFamily: 'MaterialIcons');
  static const IconData done_all_outlined =
      IconData(0xefe5, fontFamily: 'MaterialIcons');
  static const IconData push_pin_sharp =
      IconData(0xebea, fontFamily: 'MaterialIcons');
  static const IconData cancel_outlined =
      IconData(0xef28, fontFamily: 'MaterialIcons');

  static const IconData warning_amber_rounded =
      IconData(0xf02a0, fontFamily: 'MaterialIcons');

  static const IconData account_circle_outlined =
      IconData(0xee35, fontFamily: 'MaterialIcons');
  static const IconData phone_rounded =
      IconData(0xf0083, fontFamily: 'MaterialIcons');
  static const IconData pin_drop =
      IconData(0xe4c7, fontFamily: 'MaterialIcons');
  static const IconData markunread_outlined =
      IconData(0xf1b8, fontFamily: 'MaterialIcons');
  static const IconData map_outlined =
      IconData(0xf1ae, fontFamily: 'MaterialIcons');
  static const IconData maps_home_work =
      IconData(0xe3c9, fontFamily: 'MaterialIcons');
  static const IconData home_outlined =
      IconData(0xf107, fontFamily: 'MaterialIcons');

  static const IconData arrow_circle_left_outlined =
      IconData(0xf05bc, fontFamily: 'MaterialIcons');
  static const IconData arrow_circle_right_outlined =
      IconData(0xf05bd, fontFamily: 'MaterialIcons');

  static const IconData folder_open_outlined =
      IconData(0xf090, fontFamily: 'MaterialIcons');
  static const IconData search = IconData(0xe567, fontFamily: 'MaterialIcons');

  static const IconData shield_outlined =
      IconData(0xf379, fontFamily: 'MaterialIcons');
  static const IconData diversity_2_sharp =
      IconData(0xf0839, fontFamily: 'MaterialIcons');
  static const IconData radio_button_on_outlined =
      IconData(0xf2e5, fontFamily: 'MaterialIcons');
  static const IconData send_outlined =
      IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true);
  static const IconData sms_outlined =
      IconData(0xf3ad, fontFamily: 'MaterialIcons');
  static const IconData home = IconData(0xe318, fontFamily: 'MaterialIcons');
  static const IconData add = IconData(0xe047, fontFamily: 'MaterialIcons');
  static const IconData bookmarks_outlined =
      IconData(0xeee5, fontFamily: 'MaterialIcons');
}
