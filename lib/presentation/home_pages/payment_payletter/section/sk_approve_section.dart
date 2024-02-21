import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/payment_payletter/controllers/payment_payletter.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class SkApproveSection extends StatelessWidget {
  const SkApproveSection({super.key, required this.controller});

  final PaymentPayletterController controller;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.paymentPayletter != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppStyle.paddingAll12,
            width: Get.width.wr,
            decoration: BoxDecoration(
                borderRadius: AppStyle.borderRadius8All, color: kNormalColor2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Syarat & Ketentuan Paylater', style: text12BlackSemiBold),
                Gap(8.h),
                Text('"Hanya karyawan yang dapat mengajukan paylater"',
                    style: text12BlackRegular)
              ],
            ),
          ),
          Gap(24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.r,
                width: 22.r,
                child: Transform.scale(
                    scale: 0.8,
                    child: Obx(() {
                      return Checkbox(
                          activeColor: kPrimaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius6All,
                          ),
                          value: controller.aggreSkPayletter.value,
                          onChanged: (value) =>
                              controller.changeAggreSkPayletter(value!));
                    })),
              ),
              Gap(8.h),
              Expanded(
                child: Text(
                    "Dengan ini saya menyetujui Syarat dan Ketentuan Paylater, serta Kebijakan Privasi",
                    style: text12HintRegular),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
