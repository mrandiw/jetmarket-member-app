import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan_manual/controllers/add_tabungan_manual.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class PaymentMethodeSection extends StatelessWidget {
  const PaymentMethodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTabunganManualController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment Method Bank
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
                    Text('Virtual Account', style: text12BlackSemiBold),
                    Visibility(
                      visible: !controller.isBankTransferExpanded,
                      child: Row(
                          children: List.generate(
                              controller.savingPaymentMethode!.virtualAccount!
                                          .length >=
                                      3
                                  ? 3
                                  : controller.savingPaymentMethode!
                                      .virtualAccount!.length, (index) {
                        if (index == 2 &&
                            controller.savingPaymentMethode!.virtualAccount!
                                    .length >
                                3) {
                          return Container(
                            height: 26.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Center(
                                child: Text(
                              "+${controller.savingPaymentMethode!.virtualAccount!.length - 2}",
                              style: text11HintMedium,
                            )),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            height: 26.h,
                            width: 44.w,
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Image.asset(controller.assetImage(controller
                                    .savingPaymentMethode
                                    ?.virtualAccount?[index]
                                    .chCode ??
                                '')),
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
                          controller.savingPaymentMethode?.virtualAccount
                                  ?.length ??
                              0,
                          (index) => GestureDetector(
                              onTap: () => controller.actionPayment(
                                  controller.savingPaymentMethode
                                          ?.virtualAccount?[index].id ??
                                      0,
                                  controller.savingPaymentMethode
                                          ?.virtualAccount?[index].chType ??
                                      '',
                                  controller.savingPaymentMethode
                                          ?.virtualAccount?[index].chCode ??
                                      '',
                                  controller.savingPaymentMethode
                                          ?.virtualAccount?[index].name ??
                                      ''),
                              child: Container(
                                height: 36.h,
                                width: 56.w,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    color: controller.selectedBankTransfer ==
                                            controller.savingPaymentMethode
                                                ?.virtualAccount?[index].chCode
                                        ? kNormalAccentColor2
                                        : kWhite,
                                    border: AppStyle.borderAll,
                                    borderRadius: AppStyle.borderRadius8All,
                                    boxShadow: [AppStyle.boxShadowSmall]),
                                child: Image.asset(
                                  controller.getImage(controller
                                          .savingPaymentMethode
                                          ?.virtualAccount?[index]
                                          .chCode ??
                                      ''),
                                  fit: BoxFit.contain,
                                  height: 24.h,
                                  width: 44.w,
                                ),
                              )))),
                  Gap(16.h)
                ],
              ),
            ),
          ),
          Gap(12.h),

          // E-Wallets/QR Payments
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
                              controller.savingPaymentMethode!.ewalletQr!
                                          .length >=
                                      3
                                  ? 2
                                  : controller.savingPaymentMethode?.ewalletQr
                                          ?.length ??
                                      0, (index) {
                        if (index == 1 &&
                            controller.savingPaymentMethode!.ewalletQr!.length >
                                1) {
                          return Container(
                            height: 26.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Center(
                                child: Text(
                              "+${controller.savingPaymentMethode!.ewalletQr!.length - 2}",
                              style: text11HintMedium,
                            )),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                            height: 26.h,
                            width: 44.w,
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Image.asset(controller.assetImage(controller
                                    .savingPaymentMethode
                                    ?.ewalletQr?[index]
                                    .chCode ??
                                '')),
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
                          controller.savingPaymentMethode?.ewalletQr?.length ??
                              0, (index) {
                        // String assets = index ==
                        //         controller.savingPaymentMethode!.ewalletQr!
                        //                 .length -
                        //             1
                        //     ? 'qris'
                        //     : controller.savingPaymentMethode
                        //             ?.ewalletQr?[index].chCode ??
                        //         '';
                        return GestureDetector(
                          onTap: () {
                            controller.actionPayment(
                                controller.savingPaymentMethode
                                        ?.ewalletQr?[index].id ??
                                    0,
                                controller.savingPaymentMethode
                                        ?.ewalletQr?[index].chType ??
                                    '',
                                controller.savingPaymentMethode
                                        ?.ewalletQr?[index].chCode ??
                                    '',
                                controller.savingPaymentMethode
                                        ?.ewalletQr?[index].name ??
                                    '');
                          },
                          child: Container(
                            height: 36.h,
                            width: 56.w,
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                                color: controller.selectedEwallet ==
                                            controller.savingPaymentMethode
                                                ?.ewalletQr?[index].chCode &&
                                        controller.selectedChType ==
                                            controller.savingPaymentMethode
                                                ?.ewalletQr?[index].chType
                                    ? kNormalAccentColor2
                                    : kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(index ==
                                            controller.savingPaymentMethode!
                                                    .ewalletQr!.length -
                                                1
                                        ? 'assets/images/qris.png'
                                        : controller.getImage(controller
                                                .savingPaymentMethode
                                                ?.ewalletQr?[index]
                                                .chCode ??
                                            ''))),
                              ),
                            ),
                          ),
                        );
                      })),
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
                    controller.onChangeExpandRetail(expanded),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Retail Outlets', style: text12BlackSemiBold),
                    Visibility(
                      visible: !controller.isRetailExpanded,
                      child: Row(
                          children: List.generate(
                              controller.savingPaymentMethode!.otc!.length >= 3
                                  ? 3
                                  : controller.savingPaymentMethode!.otc!
                                      .length, (index) {
                        if (index == 2 &&
                            controller.savingPaymentMethode!.otc!.length > 3) {
                          return Container(
                            height: 26.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Center(
                                child: Text(
                              "+${controller.savingPaymentMethode!.otc!.length - 1}",
                              style: text11HintMedium,
                            )),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Container(
                            height: 26.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Image.asset(controller.assetImage(controller
                                    .savingPaymentMethode?.otc?[index].chCode ??
                                '')),
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
                  Row(
                      children: List.generate(
                          controller.savingPaymentMethode?.otc?.length ?? 0,
                          (index) => Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: GestureDetector(
                                  onTap: () => controller.actionPayment(
                                      controller.savingPaymentMethode
                                              ?.otc?[index].id ??
                                          0,
                                      controller.savingPaymentMethode
                                              ?.otc?[index].chType ??
                                          '',
                                      controller.savingPaymentMethode
                                              ?.otc?[index].chCode ??
                                          '',
                                      controller.savingPaymentMethode
                                              ?.otc?[index].name ??
                                          ''),
                                  child: Container(
                                      height: 36.h,
                                      width: 56.w,
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                          color: controller.selectedRetail ==
                                                  controller
                                                      .savingPaymentMethode
                                                      ?.otc?[index]
                                                      .chCode
                                              ? kNormalAccentColor2
                                              : kWhite,
                                          borderRadius:
                                              AppStyle.borderRadius8All,
                                          boxShadow: [AppStyle.boxShadowSmall]),
                                      child: Image.asset(
                                        controller.getImage(controller
                                                .savingPaymentMethode
                                                ?.otc?[index]
                                                .chCode ??
                                            ''),
                                        fit: BoxFit.contain,
                                        height: 24.h,
                                        width: 44.w,
                                      )),
                                ),
                              ))),
                  Gap(16.h)
                ],
              ),
            ),
          ),

          Gap(72.h),
        ],
      );
    });
  }
}
