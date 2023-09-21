import 'package:flutter/material.dart';
import 'package:news_white_soft/config/theme/colors.dart';

class AppFonts {
  AppFonts._();

  ///region family
  static const openSans = 'OpenSans';

  ///region weight
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
}

class AppFontStyle {
  AppFontStyle._();

  static const italic = FontStyle.italic;
}

class AppTextStyles {
  AppTextStyles._();

  static const _fontSize18 = 18.0;
  static const _fontSize20 = 20.0;

  static const size18RegularOpenSansBlack = TextStyle(
    fontSize: AppTextStyles._fontSize18,
    fontWeight: AppFonts.regular,
    color: AppColors.black,
    fontFamily: AppFonts.openSans,
  );

  static const size20ItalicOpenSansBlack = TextStyle(
    fontSize: AppTextStyles._fontSize20,
    fontWeight: AppFonts.extraLight,
    fontStyle: AppFontStyle.italic,
    color: AppColors.black,
    fontFamily: AppFonts.openSans,
  );
}