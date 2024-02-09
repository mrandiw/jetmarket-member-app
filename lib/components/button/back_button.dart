import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import '../../../utils/assets/assets_svg.dart';

enum AppBackButtonType { normal, circle }

class AppBackButton extends StatelessWidget {
  const AppBackButton._({
    super.key,
    required this.type,
  });

  factory AppBackButton.normal({
    Key? key,
  }) =>
      AppBackButton._(
        key: key,
        type: AppBackButtonType.normal,
      );

  factory AppBackButton.circle({
    Key? key,
  }) =>
      AppBackButton._(
        key: key,
        type: AppBackButtonType.circle,
      );

  final AppBackButtonType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: 24.r,
        height: 24.r,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: type == AppBackButtonType.circle
                ? const Color(0xff2D2D2D).withOpacity(0.2)
                : Colors.transparent),
        child: Center(
            child: SvgPicture.asset(
          arrowForward,
          height: 12.r,
          width: 12.r,
          colorFilter: ColorFilter.mode(
              type == AppBackButtonType.circle ? kWhite : kBlack,
              BlendMode.srcIn),
        )),
      ),
    );
  }
}
