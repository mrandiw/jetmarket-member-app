import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(
        init: DetailProductController(),
        builder: (controller) {
          return SizedBox(
            height: Get.height * 0.3,
            width: Get.width,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(
                  height: Get.height * 0.3,
                  width: Get.width,
                  color: kWhite,
                  child: PageView.builder(
                      controller: controller.pageController,
                      onPageChanged: (value) => controller.onImageSlide(value),
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return Image.network(
                            'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
                      }),
                )),
                Positioned(
                    top: 16.h,
                    right: 16.w,
                    left: 16.w,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(
                            arrowForward,
                            colorFilter:
                                const ColorFilter.mode(kBlack, BlendMode.srcIn),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 34.r,
                            width: 34.r,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius6All,
                                color: kSofterGrey),
                            child: Center(
                              child: SvgPicture.asset(
                                cartLine,
                                colorFilter: const ColorFilter.mode(
                                    kBlack, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        Gap(12.w),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 34.r,
                            width: 34.r,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius6All,
                                color: kSofterGrey),
                            child: Center(
                              child: SvgPicture.asset(
                                shareLine,
                                colorFilter: const ColorFilter.mode(
                                    kBlack, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Positioned(
                    left: 16.w,
                    bottom: 16.h,
                    child: Container(
                      height: 22.h,
                      width: 38.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.r),
                          color: kWhite),
                      child: Center(
                          child: Text('${controller.currentIndexImage + 1}/3',
                              style: text12BlackRegular)),
                    ))
              ],
            ),
          );
        });
  }
}
