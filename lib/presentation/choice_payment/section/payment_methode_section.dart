import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/choice_payment/controllers/choice_payment.controller.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/style/app_style.dart';

class PaymentMethodeSection extends StatelessWidget {
  const PaymentMethodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoicePaymentController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pilih metode pembayaran', style: text14BlackSemiBold),
            Gap(16.h),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  childrenPadding: AppStyle.paddingSide8,
                  onExpansionChanged: (bool expanded) =>
                      controller.onChangeExpandBank(expanded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bank Transfer', style: text12BlackSemiBold),
                      Visibility(
                        visible: !controller.isBankTransferExpanded,
                        child: Row(
                            children: List.generate(
                                controller.banks.length >= 3
                                    ? 3
                                    : controller.banks.length, (index) {
                          if (index == 2 && controller.banks.length > 3) {
                            return Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Center(
                                  child: Text(
                                "+${controller.banks.length - 2}",
                                style: text11HintMedium,
                              )),
                            );
                          }
                          return Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Image.asset(controller.banks[index]),
                            ),
                          );
                        })),
                      )
                    ],
                  ),
                  iconColor: kBlack,
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All),
                  children: [
                    Wrap(
                        runSpacing: 6.r,
                        spacing: 6.r,
                        children: List.generate(
                            controller.banks.length,
                            (index) => GestureDetector(
                                  onTap: () =>
                                      controller.toCheckoutPayment("bank"),
                                  child: Container(
                                    height: 36.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: AppStyle.borderRadius8All,
                                        border: AppStyle.borderAll,
                                        boxShadow: [AppStyle.boxShadowSmall]),
                                    child: Image.asset(controller.banks[index]),
                                  ),
                                ))),
                    Gap(16.h)
                  ],
                ),
              ),
            ),
            Gap(12.h),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  childrenPadding: AppStyle.paddingSide8,
                  onExpansionChanged: (bool expanded) =>
                      controller.onChangeExpandEwallet(expanded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('E-Wallets/QR Payments', style: text12BlackSemiBold),
                      Visibility(
                        visible: !controller.isEwalletExpanded,
                        child: Row(
                            children: List.generate(
                                controller.ewallets.length >= 3
                                    ? 3
                                    : controller.ewallets.length, (index) {
                          if (index == 2 && controller.ewallets.length > 3) {
                            return Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Center(
                                  child: Text(
                                "+${controller.ewallets.length - 1}",
                                style: text11HintMedium,
                              )),
                            );
                          }

                          return Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Image.asset(controller.ewallets[index]),
                            ),
                          );
                        })),
                      )
                    ],
                  ),
                  iconColor: kBlack,
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All),
                  children: [
                    Wrap(
                        runSpacing: 6.r,
                        spacing: 6.r,
                        children: List.generate(
                            controller.ewallets.length,
                            (index) => GestureDetector(
                                  onTap: () =>
                                      controller.toCheckoutPayment("wallet"),
                                  child: Container(
                                    height: 36.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: AppStyle.borderRadius8All,
                                        boxShadow: [AppStyle.boxShadowSmall]),
                                    child:
                                        Image.asset(controller.ewallets[index]),
                                  ),
                                ))),
                    Gap(16.h),
                  ],
                ),
              ),
            ),
            Gap(12.h),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  childrenPadding: AppStyle.paddingSide8,
                  onExpansionChanged: (bool expanded) =>
                      controller.onChangeExpandRetail(expanded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Retail Outlets', style: text12BlackSemiBold),
                      Visibility(
                        visible: !controller.isRetailExpanded,
                        child: Row(
                            children: List.generate(
                                controller.retail.length >= 3
                                    ? 3
                                    : controller.retail.length, (index) {
                          if (index == 2 && controller.retail.length > 3) {
                            return Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Center(
                                  child: Text(
                                "+${controller.retail.length - 1}",
                                style: text11HintMedium,
                              )),
                            );
                          }

                          return Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Container(
                              height: 26.h,
                              width: 44.w,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: Image.asset(controller.retail[index]),
                            ),
                          );
                        })),
                      )
                    ],
                  ),
                  iconColor: kBlack,
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All),
                  children: [
                    Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 6.r,
                        spacing: 6.r,
                        children: List.generate(
                            controller.retail.length,
                            (index) => GestureDetector(
                                  onTap: () =>
                                      controller.toCheckoutPayment("retail"),
                                  child: Container(
                                    height: 36.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: AppStyle.borderRadius8All,
                                        boxShadow: [AppStyle.boxShadowSmall]),
                                    child:
                                        Image.asset(controller.retail[index]),
                                  ),
                                ))),
                    Gap(16.h)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
