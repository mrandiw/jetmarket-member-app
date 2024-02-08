import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

enum AppBadgeType {
  normal,
  normalAccent,
  warning,
  primary,
  error,
  success,
  disable,
  waiting
}

class AppBadge extends StatelessWidget {
  const AppBadge(
      {super.key,
      this.type = AppBadgeType.normal,
      required this.icon,
      required this.text});

  final AppBadgeType type;
  final String icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.paddingAll8,
      decoration: BoxDecoration(
          color: colorBg(), borderRadius: BorderRadius.circular(26.r)),
      child: Row(
        children: [
          SvgPicture.asset(icon,
              colorFilter: ColorFilter.mode(colorText(), BlendMode.srcIn)),
          Gap(6.w),
          Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: colorText(),
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Color colorBg() {
    switch (type) {
      case AppBadgeType.normal:
        return kNormalColor2;
      case AppBadgeType.normalAccent:
        return kNormalAccentColor2;
      case AppBadgeType.warning:
        return kWarning2Color;
      case AppBadgeType.primary:
        return kPrimaryColor2;
      case AppBadgeType.error:
        return kPrimaryColor2;
      case AppBadgeType.success:
        return kSuccessColor2;
      case AppBadgeType.disable:
        return kDisable2;
      case AppBadgeType.waiting:
        return const Color(0xffFEF7F1);
    }
  }

  Color colorText() {
    switch (type) {
      case AppBadgeType.normal:
        return kNormalColor;
      case AppBadgeType.normalAccent:
        return kNormalAccentColor;
      case AppBadgeType.warning:
        return kWarningColor;
      case AppBadgeType.primary:
        return kPrimaryColor;
      case AppBadgeType.error:
        return kPrimaryColor;
      case AppBadgeType.success:
        return kSuccessColor;
      case AppBadgeType.disable:
        return kDisable;
      case AppBadgeType.waiting:
        return const Color(0xffD6761E);
    }
  }
}
