import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/topup_saldo/controllers/topup_saldo.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class PaymentMethode extends StatelessWidget {
  const PaymentMethode({super.key, required this.controller});
  final TopupSaldoController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppStyle.paddingAll16,
      children: [
        Text('Pilih Metode Top Up', style: text14BlackMedium),
        Gap(12.h),
        SizedBox(
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () => controller.onChangePaymentMethode(
                          controller.listPayment[index]),
                      child: Container(
                        padding: AppStyle.paddingAll12,
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8All,
                            border: AppStyle.borderAll),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: AppStyle.paddingAll8,
                                decoration: BoxDecoration(
                                  borderRadius: AppStyle.borderRadius8All,
                                ),
                                child: Image.asset(
                                  'assets/images/${controller.listPayment[index]}.png',
                                  height: 12.h,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Obx(() {
                                return Visibility(
                                    visible: controller
                                            .selectedPaymentMethode.value ==
                                        controller.listPayment[index],
                                    child: const Icon(
                                      Icons.check,
                                      color: kPrimaryColor,
                                    ));
                              })
                            ]),
                      ),
                    ),
                separatorBuilder: (_, i) => Gap(12.h),
                itemCount: controller.listPayment.length))
      ],
    );
  }
}
