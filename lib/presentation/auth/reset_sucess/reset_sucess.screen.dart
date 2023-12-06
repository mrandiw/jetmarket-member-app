import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/button/app_button.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/assets/assets_svg.dart';
import 'controllers/reset_sucess.controller.dart';

class ResetSucessScreen extends GetView<ResetSucessController> {
  const ResetSucessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteBackground,
        body: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(lockBlue)),
              Gap(26.h),
              Text('Password Berhasil Diubah', style: text20PrimarySemiBold),
              Text('Silakan login untuk mulai berjualan.',
                  style: text14BlackRegular),
              Gap(26.h),
              AppButton.primary(
                text: 'Login',
                onPressed: () => Get.offNamed(Routes.LOGIN),
              )
            ],
          ),
        ));
  }
}
