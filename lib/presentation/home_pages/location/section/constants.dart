import 'package:flutter/material.dart';

const containerRadius = 12.0;
const buttonRadius = 10.0;
const formRadius = 10.0;
const dialogRadius = 15.0;
const containerPadding = 32.0;
const buttonPadding = 8.0;

class AppColors {
  static const Color primaryColor = Color(0xFFDB4C45);
  static const Color contextBlue = Color(0xFF3D7FFE);
  static const Color contextGrey = Color(0xFFA0A3BD);
  static const Color contextGreen = Color(0xFF19C85F);
  static const Color textGray = Color(0xFF8C8FB0);
  static const Color textGrayFaded = Color(0xFFAFB6C6);
  static Color shadowColor = contextGrey.withOpacity(0.5);
  static Color formBorderColor = contextGrey.withOpacity(0.4);
  static Color formIconColor = const Color(0xFF8C8C8C).withOpacity(0.5);
  static const Color popupMenuItemColor = Color(0xFF66738F);
  static const Color backgroundColor = Color(0xFFEFF4F8);
  static const Color oddTableRowColor = Color(0xFFEBEBF8);
  static const Color productImagePlaceholderBorderColor = Color(0xFFCCD6DE);
  static const Color productImagePlaceholderBackgroundColor = Color(0xFFDFE9F0);
  static const Color productImagePlaceholderTextColor = Color(0xFFABBBC6);
  static const Color quantityButtonBorderColor = Color(0xFFE2E3F3);
  static const Color eraseGrey = Color(0xFFC9CBDD);
  static const Color eraseGreyLight = Color(0xFFE8E8F8);
  static const Color eraseGreyDark = Color(0xFF80839F);
  static const Color priceGrey = Color(0xFF8E91AF);
}