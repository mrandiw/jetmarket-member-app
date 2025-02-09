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
          return Column(
            children: [
              Expanded(
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
                              controller.onboardingData[index]["image"],
                              height: 264.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              2,
                              (indexDot) => Container(
                                width: 6.r,
                                height: 6.r,
                                margin: EdgeInsets.only(right: 6.w, top: 12.0),
                                decoration: BoxDecoration(
                                  color: indexDot == index
                                      ? kPrimaryColor
                                      : kPrimaryColor2,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 46.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16
                                    .w), // Tambahkan padding untuk menghindari overflow
                            child: Text(
                              controller.onboardingData[index]["title"],
                              style: text20BlackSemiBold,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow
                                  .ellipsis, // Hindari overflow teks
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              controller.onboardingData[index]['subtitle'],
                              style: text14BlackRegular,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow
                                  .ellipsis, // Hindari overflow teks
                            ),
                          ),
                          SizedBox(height: 46.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: AppStyle.paddingAll16,
                child: AppButton.primary(
                  text: 'Lanjut',
                  onPressed: () => controller.nextPage(),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          );
        }),
      ),
    );
  }
}
