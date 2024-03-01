import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class VoucherSection extends StatelessWidget {
  const VoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.VOUCHER);
        },
        child: GetBuilder<CheckoutController>(builder: (controller) {
          return Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: AppStyle.borderRadius8All,
                side: AppStyle.borderSide),
            child: Padding(
              padding: AppStyle.paddingAll16,
              child: Row(
                children: [
                  SvgPicture.asset(voucher),
                  Gap(8.w),
                  Text(
                      controller.selectedVouchername == null
                          ? 'Voucher'
                          : "Voucher ${controller.selectedVouchername} Terpakai",
                      style: text12BlackRegular),
                  const Spacer(),
                  SvgPicture.asset(arrowRight)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
