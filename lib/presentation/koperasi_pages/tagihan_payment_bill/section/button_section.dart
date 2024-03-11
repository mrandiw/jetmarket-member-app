import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../controllers/tagihan_payment_bill.controller.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key, required this.controller});

  final TagihanPaymentBillController controller;

  @override
  Widget build(BuildContext context) {
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
        text: 'Back To Merchent',
        onPressed: () => controller.toMain(),
      ),
    );
  }
}
