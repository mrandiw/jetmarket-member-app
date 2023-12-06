import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

class AppStyle {
  // Padding
  static EdgeInsets paddingAll16 = EdgeInsets.all(16.r);
  static EdgeInsets paddingAll12 = EdgeInsets.all(12.r);
  static EdgeInsets paddingAll8 = EdgeInsets.all(8.r);
  static EdgeInsets paddingSide16 = EdgeInsets.symmetric(horizontal: 16.r);
  static EdgeInsets paddingSide12 = EdgeInsets.symmetric(horizontal: 12.r);
  static EdgeInsets paddingSide8 = EdgeInsets.symmetric(horizontal: 8.r);
  static EdgeInsets paddingVert16 = EdgeInsets.symmetric(vertical: 16.r);
  static EdgeInsets paddingVert12 = EdgeInsets.symmetric(vertical: 12.r);
  static EdgeInsets paddingVert8 = EdgeInsets.symmetric(vertical: 8.r);
  static EdgeInsets paddingBottom16 = EdgeInsets.only(bottom: 16.r);
  static EdgeInsets paddingBottom12 = EdgeInsets.only(bottom: 12.r);
  static EdgeInsets paddingBottom8 = EdgeInsets.only(bottom: 8.r);

  // Border

  static Border borderAll = Border.all(width: 1.r, color: kBorder);
  static BorderSide borderSide = BorderSide(width: 1.r, color: kBorder);
  static BorderRadius borderRadius8All = BorderRadius.circular(8.r);
  static BorderRadius borderRadius6All = BorderRadius.circular(6.r);
  static BorderRadius borderRadius8Top = BorderRadius.only(
      topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r));
  static BorderRadius borderRadius20Top = BorderRadius.only(
      topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r));

  // Shadow

  static BoxShadow boxShadow = BoxShadow(
      color: const Color(0xffE0E0EC).withOpacity(0.4),
      offset: const Offset(0, 15),
      blurRadius: 30,
      spreadRadius: 0);

  static BoxShadow boxShadowSmall = BoxShadow(
      color: const Color(0xffA0A3BD).withOpacity(0.1),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0);
}
