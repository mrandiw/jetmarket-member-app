import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

AppBar get appBarKoperasi {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0.3,
    toolbarHeight: 52.hr,
    centerTitle: false,
    title: Text('Koperasi', style: text14BlackMedium),
    actions: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.CART),
        child: SvgPicture.asset(
          cart,
          // height: 14.wr,
          // fit: BoxFit.fitHeight,
        ),
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
