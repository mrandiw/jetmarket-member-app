import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

class CustomStepperRefund extends StatelessWidget {
  final int currentStep;

  const CustomStepperRefund({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    List<String> icons = [box, shippingFast, openPackage, inboxSuccess];
    return SizedBox(
      height: 40.h,
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          bool isActive = index <= currentStep - 1;
          return Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? Colors.transparent : kBorder,
                    width: 1.5,
                  ),
                  color: isActive ? kPrimaryColor : Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icons[index],
                    colorFilter: ColorFilter.mode(
                      isActive ? kWhite : kSoftGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              if (index < 3)
                Container(
                  width: (Get.width - (40 * 4).r) / 4.1,
                  height: 1.4,
                  color: isActive ? kPrimaryColor : kBorder,
                ),
            ],
          );
        }),
      ),
    );
  }
}
