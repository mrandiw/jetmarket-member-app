import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/onboarding.controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackground,
      body: SafeArea(
        child: GetBuilder<OnboardingController>(builder: (controller) {
          return Builder(builder: (context) {
            return ListView(
              padding: AppStyle.paddingAll16,
              children: [
                Gap(44.h),
                Center(
                  child: Image.asset(
                    controller.onboardingData[controller.currentIndex]["image"],
                    height: 264.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => Container(
                        width: 6.r,
                        height: 6.r,
                        margin: EdgeInsets.only(
                          right: 6.w,
                          top: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: index == controller.currentIndex
                              ? kPrimaryColor
                              : kPrimaryColor2,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 46.h),
                Text(
                  controller.onboardingData[controller.currentIndex]["title"],
                  style: text20BlackSemiBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  controller.onboardingData[controller.currentIndex]
                      ['subtitle'],
                  style: text14BlackRegular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 46.h),
                SizedBox(
                  child: AppButton.primary(
                    text: 'Lanjut',
                    onPressed: () => controller.skipOnboarding(),
                  ),
                ),
                SizedBox(height: 46.h),
              ],
            );
          });
        }),
      ),
    );
  }
}
