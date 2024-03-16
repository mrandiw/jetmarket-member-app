import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
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
          return Column(
            // padding: AppStyle.paddingAll16,
            children: [
              SizedBox(
                height: Get.height.hr * 0.7,
                child: Padding(
                  padding: AppStyle.paddingSide16,
                  child: PageView.builder(
                      controller: controller.pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            Gap(44.h),
                            Center(
                              child: Image.asset(
                                controller
                                        .onboardingData[controller.currentIndex]
                                    ["image"],
                                height: 264.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 20.h,
                              width: Get.width.wr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    2,
                                    (indexDot) => Container(
                                          width: 6.r,
                                          height: 6.r,
                                          margin: EdgeInsets.only(
                                            right: 6.w,
                                            top: 12.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: indexDot == index
                                                ? kPrimaryColor
                                                : kPrimaryColor2,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            SizedBox(height: 46.h),
                            Text(
                              controller.onboardingData[index]["title"],
                              style: text20BlackSemiBold,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              controller.onboardingData[index]['subtitle'],
                              style: text14BlackRegular,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 46.h),
                          ],
                        );
                      }),
                ),
              ),
              Padding(
                padding: AppStyle.paddingAll16,
                child: AppButton.primary(
                  text: 'Lanjut',
                  onPressed: () => controller.nextPage(),
                ),
              ),
              SizedBox(height: 46.h),
            ],
          );
        }),
      ),
    );
  }
}
