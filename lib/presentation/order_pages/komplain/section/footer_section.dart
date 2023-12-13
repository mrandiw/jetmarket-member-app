import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/komplain/controllers/komplain.controller.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KomplainController>(builder: (controller) {
      return Container(
        height: 76.h,
        width: Get.width,
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(color: kWhite, boxShadow: [
          BoxShadow(
              color: const Color(0xffE3BEBD).withOpacity(0.08),
              offset: const Offset(0, -6),
              blurRadius: 10)
        ]),
        child: AppButton.primary(
          text: 'Kirim Pengajuan',
          onPressed: controller.addProduct.isNotEmpty
              ? () => controller.sendComplain()
              : null,
        ),
      );
    });
  }
}
