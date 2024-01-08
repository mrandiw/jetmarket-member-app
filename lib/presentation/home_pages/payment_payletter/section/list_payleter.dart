import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/payment_payletter/controllers/payment_payletter.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class ListPayletterSection extends StatelessWidget {
  const ListPayletterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentPayletterController>(builder: (controller) {
      return Visibility(
        visible: controller.paymentPayletter != null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih Payleter', style: text14BlackSemiBold),
            Gap(12.hr),
            SizedBox(
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) => GestureDetector(
                          onTap: () => controller.selectPayleter(index),
                          child: Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              color: kWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: AppStyle.borderRadius8All,
                                  side: AppStyle.borderSide),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${controller.paymentPayletter?.installments?[index].name}",
                                            style: text12BlackRegular),
                                        Visibility(
                                          visible: controller
                                                  .paymentPayletter
                                                  ?.installments?[index]
                                                  .chCode ==
                                              '1x',
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8.h),
                                            child: Text(
                                              'Rp.0 Tersisa',
                                              style: text12HintRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                        "${"${controller.paymentPayletter?.installments?[index].value}".toIdrFormat}${controller.paymentPayletter?.installments?[index].chCode != '1x' ? '/bulan' : ''}",
                                        style: text12BlackRegular),
                                    Gap(6.w),
                                    SizedBox(
                                      width: 26.w,
                                      child: RadioListTile(
                                          activeColor: kPrimaryColor,
                                          fillColor: MaterialStateProperty.all(
                                              controller.seledtedPayleterIndex ==
                                                      index
                                                  ? kPrimaryColor
                                                  : kDivider),
                                          value: index,
                                          selected:
                                              controller.seledtedPayleterIndex ==
                                                  index,
                                          groupValue:
                                              controller.seledtedPayleterIndex,
                                          onChanged: (value) => controller
                                              .selectPayleter(value!)),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                    separatorBuilder: (_, i) => Gap(8.hr),
                    itemCount:
                        controller.paymentPayletter?.installments?.length ??
                            0)),
            Gap(16.hr),
          ],
        ),
      );
    });
  }
}
