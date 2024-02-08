import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../controllers/detail_bill_paylater.controller.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});

  final DetailBillPaylaterController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailBillPaylaterController>(builder: (controller) {
      return Container(
          height: 72.h,
          padding: AppStyle.paddingAll16,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius20Top,
              color: kWhite,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xffE3BEBD).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -6))
              ]),
          child: AppButton.primary(
              text: 'Bayar Tagihan ${'${Get.arguments[2]}'.toIdrFormat}',
              onPressed: () => controller.toChoicePayment()));
    });
  }
}
