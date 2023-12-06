import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../button/app_button.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet(
      {super.key,
      required this.title,
      required this.textButton,
      required this.child,
      this.isFooter = true,
      this.gapBottom,
      this.onPressed});
  const AppBottomSheet.witoutFooter(
      {super.key,
      required this.title,
      this.textButton = "",
      required this.child,
      this.isFooter = false,
      this.gapBottom,
      this.onPressed});

  final String title;
  final String textButton;
  final Widget child;
  final bool isFooter;
  final double? gapBottom;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.9,
            minHeight: Get.height * 0.1,
          ),
          child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Gap(30.h),
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: SizedBox(child: child),
                        ),
                        SizedBox(height: isFooter ? gapBottom ?? 100.w : 32.w),
                      ],
                    ),
                  )),
                  Positioned(
                      top: 0,
                      right: 16.w,
                      left: 16.w,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(16.h),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      size: 16.r,
                                    )),
                                Gap(8.w),
                                Text(title, style: text16BlackSemiBold),
                              ],
                            ),
                            Gap(16.h),
                          ])),
                  isFooter
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                              width: Get.width,
                              child: Container(
                                height: 72.h,
                                padding: EdgeInsets.all(16.r),
                                decoration: const BoxDecoration(color: kWhite),
                                child: AppButton.primary(
                                    text: textButton, onPressed: onPressed),
                              )))
                      : const SizedBox(),
                ],
              ))),
    );
  }
}
