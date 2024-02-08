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
                    Text('Virtual Account', style: text12BlackRegular),
                    Visibility(
                      visible: !controller.isBankTransferExpanded,
                      child: Row(
                          children: List.generate(
                              controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .length >=
                                      3
                                  ? 3
                                  : controller.savingPaymentMethode!.items!
                                      .where(
                                          (e) => e.chType == 'VIRTUAL_ACCOUNT')
                                      .length, (index) {
                        if (index == 2 &&
                            controller.savingPaymentMethode!.items!
                                    .where((e) => e.chType == 'VIRTUAL_ACCOUNT')
                                    .length >
                                3) {
                          return Container(
                            height: 26.h,
                            width: 44.w,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: AppStyle.borderRadius8All,
                                border: AppStyle.borderAll,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Center(
                                child: Text(
                              "+${controller.savingPaymentMethode!.items!.where((e) => e.chType == 'VIRTUAL_ACCOUNT').length - 2}",
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
                              child: Image.asset(controller.assetImage(
                                  controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
                                          .chCode ??
                                      ''))),
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
                          controller.savingPaymentMethode?.items
                                  ?.where((e) => e.chType == 'VIRTUAL_ACCOUNT')
                                  .length ??
                              0,
                          (index) => GestureDetector(
                              onTap: () => controller.actionPayment(
                                  controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
                                          .id ??
                                      0,
                                  controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
                                          .chType ??
                                      '',
                                  controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
                                          .chCode ??
                                      '',
                                  controller.savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
                                          .name ??
                                      ''),
                              child: Container(
                                height: 36.h,
                                width: 56.w,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    color: controller.selectedBankTransfer ==
                                            controller
                                                .savingPaymentMethode!.items!
                                                .where((e) =>
                                                    e.chType ==
                                                    'VIRTUAL_ACCOUNT')
                                                .elementAt(index)
                                                .id
                                                .toString()
                                        ? kNormalAccentColor2
                                        : kWhite,
                                    border: AppStyle.borderAll,
                                    borderRadius: AppStyle.borderRadius8All,
                                    boxShadow: [AppStyle.boxShadowSmall]),
                                child: Image.asset(
                                  controller.getImage(controller
                                          .savingPaymentMethode!.items!
                                          .where((e) =>
                                              e.chType == 'VIRTUAL_ACCOUNT')
                                          .elementAt(index)
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
                    Text('E-Wallets/QR Payments', style: text12BlackRegular),
                    Visibility(
                      visible: !controller.isEwalletExpanded,
                      child: Row(
                          children: List.generate(
                              controller.savingPaymentMethode!.items!
                                          .where((e) => e.chType == 'EWALLET')
                                          .length >=
                                      3
                                  ? 2
                                  : controller.savingPaymentMethode!.items!
                                      .where((e) => e.chType == 'EWALLET')
                                      .length, (index) {
                        if (index == 1 &&
                            controller.savingPaymentMethode!.items!
                                    .where((e) => e.chType == 'EWALLET')
                                    .length >
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
                              "+${controller.savingPaymentMethode!.items!.where((e) => e.chType == 'EWALLET').length - 2}",
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
                                    .savingPaymentMethode!.items!
                                    .where((e) => e.chType == 'EWALLET')
                                    .elementAt(index)
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
                          controller.savingPaymentMethode!.items!
                              .where((e) => e.chType == 'EWALLET')
                              .length, (index) {
                        // String assets = index ==
                        //         controller.savingPaymentMethode!.items!.where((e) => e.chType=='').ewalletQr!
                        //                 .length -
                        //             1
                        //     ? 'qris'
                        //     : controller.paymentMethodes?.ewalletQr?[index]
                        //             .chCode ??
                        //         '';
                        return GestureDetector(
                          onTap: () {
                            controller.actionPayment(
                                controller.savingPaymentMethode!.items!
                                        .where((e) => e.chType == 'EWALLET')
                                        .elementAt(index)
                                        .id ??
                                    0,
                                controller.savingPaymentMethode!.items!
                                        .where((e) => e.chType == 'EWALLET')
                                        .elementAt(index)
                                        .chType ??
                                    '',
                                controller.savingPaymentMethode!.items!
                                        .where((e) => e.chType == 'EWALLET')
                                        .elementAt(index)
                                        .chCode ??
                                    '',
                                controller.savingPaymentMethode!.items!
                                        .where((e) => e.chType == 'EWALLET')
                                        .elementAt(index)
                                        .name ??
                                    '');
                          },
                          child: Container(
                            height: 36.h,
                            width: 56.w,
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                                color: controller.selectedEwallet ==
                                        controller.savingPaymentMethode!.items!
                                            .where((e) => e.chType == 'EWALLET')
                                            .elementAt(index)
                                            .id
                                            .toString()
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
                                                    .items!
                                                    .where((e) =>
                                                        e.chType == 'EWALLET')
                                                    .length -
                                                1
                                        ? 'assets/images/qris.png'
                                        : controller.getImage(controller
                                                .savingPaymentMethode!.items!
                                                .where((e) =>
                                                    e.chType == 'EWALLET')
                                                .elementAt(index)
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
                    Text('Retail Outlets', style: text12BlackRegular),
                    Visibility(
                      visible: !controller.isRetailExpanded,
                      child: Row(
                          children: List.generate(
                              controller.savingPaymentMethode!.items!
                                          .where((e) => e.chType == 'OTC')
                                          .length >=
                                      3
                                  ? 3
                                  : controller.savingPaymentMethode!.items!
                                      .where((e) => e.chType == 'OTC')
                                      .length, (index) {
                        if (index == 2 &&
                            controller.savingPaymentMethode!.items!
                                    .where((e) => e.chType == 'OTC')
                                    .length >
                                3) {
                          return Container(
                            height: 26.h,
                            width: 44.w,
                            padding: AppStyle.paddingSide8,
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Center(
                                child: Text(
                              "+${controller.savingPaymentMethode!.items!.where((e) => e.chType == 'OTC').length - 1}",
                              style: text11HintMedium,
                            )),
                          );
                        }

                        return Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Container(
                            height: 26.h,
                            width: 44.w,
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                                color: kWhite,
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                boxShadow: [AppStyle.boxShadowSmall]),
                            child: Image.asset(controller.assetImage(controller
                                    .savingPaymentMethode!.items!
                                    .where((e) => e.chType == 'OTC')
                                    .elementAt(index)
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
                  Row(
                      children: List.generate(
                          controller.savingPaymentMethode!.items!
                              .where((e) => e.chType == 'OTC')
                              .length,
                          (index) => Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: GestureDetector(
                                  onTap: () => controller.actionPayment(
                                      controller.savingPaymentMethode!.items!
                                              .where((e) => e.chType == 'OTC')
                                              .elementAt(index)
                                              .id ??
                                          0,
                                      controller.savingPaymentMethode!.items!
                                              .where((e) => e.chType == 'OTC')
                                              .elementAt(index)
                                              .chType ??
                                          '',
                                      controller.savingPaymentMethode!.items!
                                              .where((e) => e.chType == 'OTC')
                                              .elementAt(index)
                                              .chCode ??
                                          '',
                                      controller.savingPaymentMethode!.items!
                                              .where((e) => e.chType == 'OTC')
                                              .elementAt(index)
                                              .name ??
                                          ''),
                                  child: Container(
                                      height: 36.h,
                                      width: 56.w,
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                          color: controller.selectedRetail ==
                                                  controller
                                                      .savingPaymentMethode!
                                                      .items!
                                                      .where((e) =>
                                                          e.chType == 'OTC')
                                                      .elementAt(index)
                                                      .id
                                                      .toString()
                                              ? kNormalAccentColor2
                                              : kWhite,
                                          borderRadius:
                                              AppStyle.borderRadius8All,
                                          boxShadow: [AppStyle.boxShadowSmall]),
                                      child: Image.asset(
                                        controller.getImage(controller
                                                .savingPaymentMethode!.items!
                                                .where((e) => e.chType == 'OTC')
                                                .elementAt(index)
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
