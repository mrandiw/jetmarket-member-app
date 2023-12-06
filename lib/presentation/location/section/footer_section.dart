import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/location/controllers/location.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding: AppStyle.paddingAll16,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: AppStyle.borderRadius20Top,
          boxShadow: [
            BoxShadow(
                color: const Color(0xffE3BEBD).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -6))
          ]),
      child: GetBuilder<LocationController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.label, style: text12BlackSemiBold),
            Gap(4.h),
            Text(controller.address, style: text12HintRegular),
            Gap(8.h),
            AppButton.primary(
              text: 'Pilih Lokasi',
              onPressed: !controller.isLoading
                  ? () => controller.selectLocation()
                  : null,
            ),
          ],
        );
      }),
    );
  }
}
