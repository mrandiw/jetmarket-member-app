import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/onboarding.controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({Key? key}) : super(key: key);
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
                CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.46,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      controller.nextOnboarding(index);
                    },
                  ),
                  items: controller.onboardingData.map((onboarding) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                onboarding["image"],
                                height: 264.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      controller.onboardingData.asMap().entries.map((entry) {
                    bool isSelected = controller.currentIndex == entry.key;
                    return GestureDetector(
                      onTap: () => controller.carouselController
                          .animateToPage(entry.key),
                      child: Container(
                        width: 6.r,
                        height: 6.r,
                        margin: EdgeInsets.only(
                          right: 6.w,
                          top: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? kPrimaryColor : kPrimaryColor2,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 46.h),
                CarouselSlider(
                  carouselController: controller.carouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.2,
                    autoPlay: false,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    viewportFraction: 1.0,
                  ),
                  items: controller.onboardingData.map((onboarding) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(onboarding["title"],
                                style: text20BlackSemiBold),
                            SizedBox(height: 12.h),
                            Text(
                              onboarding['subtitle'],
                              style: text14BlackRegular,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  child: AppButton.primary(
                    text: 'Lanjut',
                    onPressed: () => controller.skipOnboarding(),
                  ),
                )
              ],
            );
          });
        }),
      ),
    );
  }
}
