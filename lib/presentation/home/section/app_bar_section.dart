import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar get appBarHome {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0.3,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi Clara!', style: text14BlackRegular),
        Text('Ayo checkout keranjangmu!', style: text14BlackMedium)
      ],
    ),
    actions: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.CART),
        child: SvgPicture.asset(cart),
      ),
      Gap(10.w),
      GestureDetector(
        onTap: () => Get.toNamed(Routes.NOTIFICATION),
        child: Icon(
          Icons.notifications,
          color: const Color(0xff333333).withOpacity(0.4),
        ),
      ),
      Gap(16.w)
    ],
  );
}
