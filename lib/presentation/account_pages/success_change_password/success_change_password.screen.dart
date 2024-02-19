import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';
import 'controllers/success_change_password.controller.dart';
import 'section/app_bar_section.dart';

class SuccessChangePasswordScreen
    extends GetView<SuccessChangePasswordController> {
  const SuccessChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSuccessChangePassword,
        backgroundColor: kWhite,
        body: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(lockBlue)),
              Gap(26.h),
              Text('Password Berhasil Direset', style: text20PrimarySemiBold),
              Gap(26.h),
              AppButton.primary(
                text: 'Kembali',
                onPressed: () => Get.back(),
              )
            ],
          ),
        ));
  }
}
