import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/back_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import '../../../../utils/assets/assets_images.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 302.h,
        width: Get.width,
        color: kPrimaryColor2,
        child: Stack(
          children: [
            Image.asset(authImage),
            Positioned(top: 16.h, left: 16.w, child: AppBackButton.circle())
          ],
        ));
  }
}
