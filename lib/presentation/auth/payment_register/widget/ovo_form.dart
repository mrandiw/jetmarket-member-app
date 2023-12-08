import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/payment_register/controllers/payment_register.controller.dart';

class OvoForm extends StatelessWidget {
  const OvoForm({super.key, required this.controller});
  final PaymentRegisterController controller;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: '',
      textButton: 'Bayar',
      onPressed: () {
        Get.back();
        controller.createPaymentCustomer();
      },
      gapBottom: 72.h,
      child: content,
    );
  }

  Widget get content {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Silahkan masukan nomor hp', style: text14BlackRegular),
        Gap(12.h),
        AppForm(
          controller: controller.numberController,
        )
      ],
    );
  }
}
