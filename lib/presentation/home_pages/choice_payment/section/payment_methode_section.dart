import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/choice_payment/controllers/choice_payment.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../../../../utils/style/app_style.dart';

class PaymentMethodeSection extends StatelessWidget {
  const PaymentMethodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoicePaymentController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pilih Metode Pembayaran', style: text14BlackSemiBold),
              Gap(16.h),
              Visibility(
                visible: controller.paymentMethodes?.saldo != null,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: GestureDetector(
                    onTap: () => controller.actionPayment(
                        0,
                        controller.paymentMethodes?.saldo?[0].chType ?? '',
                        controller.paymentMethodes?.saldo?[0].chCode ?? '',
                        controller.paymentMethodes?.saldo?[0].name ?? ''),
                    child: Container(
                      height: 60.hr,
                      width: Get.width.wr,
                      padding: AppStyle.paddingAll12,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: AppStyle.borderRadius8All,
                          border: AppStyle.borderAll),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Saldo', style: text12BlackRegular),
                          Text(
                              '${controller.paymentMethodes?.saldo?[0].amount}'
                                  .toIdrFormat,
                              style: text12NormalRegular)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                                  controller.paymentMethodes!.virtualAccount!
                                              .length >=
                                          3
                                      ? 3
                                      : controller.paymentMethodes!
                                          .virtualAccount!.length, (index) {
                            if (index == 2 &&
                                controller.paymentMethodes!.virtualAccount!
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
                                  "+${controller.paymentMethodes!.virtualAccount!.length - 2}",
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
                                    controller.paymentMethodes
                                            ?.virtualAccount?[index].chCode ??
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
                              controller
                                      .paymentMethodes?.virtualAccount?.length ??
                                  0,
                              (index) => GestureDetector(
                                  onTap: () => controller.actionPayment(
                                      controller.paymentMethodes
                                              ?.virtualAccount?[index].id ??
                                          0,
                                      controller.paymentMethodes
                                              ?.virtualAccount?[index].chType ??
                                          '',
                                      controller.paymentMethodes
                                              ?.virtualAccount?[index].chCode ??
                                          '',
                                      controller.paymentMethodes
                                              ?.virtualAccount?[index].name ??
                                          ''),
                                  child: Container(
                                    height: 36.h,
                                    width: 56.w,
                                    padding: EdgeInsets.all(8.r),
                                    decoration: BoxDecoration(
                                        color:
                                            controller.selectedBankTransfer ==
                                                    controller
                                                        .paymentMethodes
                                                        ?.virtualAccount?[index]
                                                        .id
                                                        .toString()
                                                ? kNormalAccentColor2
                                                : kWhite,
                                        border: AppStyle.borderAll,
                                        borderRadius: AppStyle.borderRadius8All,
                                        boxShadow: [AppStyle.boxShadowSmall]),
                                    child: Image.asset(
                                      controller.getImage(controller
                                              .paymentMethodes
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
                        Text('E-Wallets/QR Payments',
                            style: text12BlackSemiBold),
                        Visibility(
                          visible: !controller.isEwalletExpanded,
                          child: Row(
                              children: List.generate(
                                  controller.paymentMethodes!.ewalletQr!
                                              .length >=
                                          3
                                      ? 2
                                      : controller.paymentMethodes?.ewalletQr
                                              ?.length ??
                                          0, (index) {
                            if (index == 1 &&
                                controller.paymentMethodes!.ewalletQr!.length >
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
                                  "+${controller.paymentMethodes!.ewalletQr!.length - 2}",
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
                                child: Image.asset(controller.assetImage(
                                    controller.paymentMethodes
                                            ?.ewalletQr?[index].chCode ??
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
                              controller.paymentMethodes?.ewalletQr?.length ??
                                  0, (index) {
                            // String assets = index ==
                            //         controller.paymentMethodes!.ewalletQr!
                            //                 .length -
                            //             1
                            //     ? 'qris'
                            //     : controller.paymentMethodes?.ewalletQr?[index]
                            //             .chCode ??
                            //         '';
                            return GestureDetector(
                              onTap: () {
                                controller.actionPayment(
                                    controller.paymentMethodes
                                            ?.ewalletQr?[index].id ??
                                        0,
                                    controller.paymentMethodes
                                            ?.ewalletQr?[index].chType ??
                                        '',
                                    controller.paymentMethodes
                                            ?.ewalletQr?[index].chCode ??
                                        '',
                                    controller.paymentMethodes
                                            ?.ewalletQr?[index].name ??
                                        '');
                              },
                              child: Container(
                                height: 36.h,
                                width: 56.w,
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                    color: controller.selectedEwallet ==
                                            controller.paymentMethodes
                                                ?.ewalletQr?[index].id
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
                                                controller.paymentMethodes!
                                                        .ewalletQr!.length -
                                                    1
                                            ? 'assets/images/qris.png'
                                            : controller.getImage(controller
                                                    .paymentMethodes
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
                                  controller.paymentMethodes!.otc!.length >= 3
                                      ? 3
                                      : controller.paymentMethodes!.otc!.length,
                                  (index) {
                            if (index == 2 &&
                                controller.paymentMethodes!.otc!.length > 3) {
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
                                  "+${controller.paymentMethodes!.otc!.length - 1}",
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
                                child: Image.asset(controller.assetImage(
                                    controller.paymentMethodes?.otc?[index]
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
                              controller.paymentMethodes?.otc?.length ?? 0,
                              (index) => Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: GestureDetector(
                                      onTap: () => controller.actionPayment(
                                          controller.paymentMethodes
                                                  ?.otc?[index].id ??
                                              0,
                                          controller.paymentMethodes
                                                  ?.otc?[index].chType ??
                                              '',
                                          controller.paymentMethodes
                                                  ?.otc?[index].chCode ??
                                              '',
                                          controller.paymentMethodes
                                                  ?.otc?[index].name ??
                                              ''),
                                      child: Container(
                                          height: 36.h,
                                          width: 56.w,
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                              color:
                                                  controller.selectedRetail ==
                                                          controller
                                                              .paymentMethodes
                                                              ?.otc?[index]
                                                              .id
                                                              .toString()
                                                      ? kNormalAccentColor2
                                                      : kWhite,
                                              borderRadius:
                                                  AppStyle.borderRadius8All,
                                              boxShadow: [
                                                AppStyle.boxShadowSmall
                                              ]),
                                          child: Image.asset(
                                            controller.getImage(controller
                                                    .paymentMethodes
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
              // Payletter

              Gap(12.h),
              Visibility(
                visible: controller.paymentMethodes?.paylater != null,
                child: Container(
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
                          controller.onChangeExpandPayletter(expanded),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payletter', style: text12BlackSemiBold),
                          Visibility(
                            visible: !controller.isPayletterExpanded,
                            child: Container(
                              height: 26.h,
                              width: 44.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  border: AppStyle.borderAll,
                                  borderRadius: AppStyle.borderRadius8All,
                                  boxShadow: [AppStyle.boxShadowSmall]),
                              child: SvgPicture.asset(paymentClock),
                            ),
                          )
                        ],
                      ),
                      iconColor: kBlack,
                      collapsedShape: RoundedRectangleBorder(
                          borderRadius: AppStyle.borderRadius8All),
                      children: [
                        Wrap(
                            spacing: 8.r,
                            runSpacing: 8.r,
                            children: List.generate(
                                controller.paymentMethodes?.paylater?.length ??
                                    0,
                                (index) => GestureDetector(
                                      onTap: () => controller.actionPayment(
                                          controller.paymentMethodes
                                                  ?.paylater?[index].id ??
                                              0,
                                          controller.paymentMethodes
                                                  ?.paylater?[index].chType ??
                                              '',
                                          controller.paymentMethodes
                                                  ?.paylater?[index].chCode ??
                                              '',
                                          controller.paymentMethodes
                                                  ?.paylater?[index].name ??
                                              ''),
                                      child: Container(
                                          width: Get.width * 0.25,
                                          height: 52.h,
                                          padding: EdgeInsets.all(8.r),
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .selectedPayletter ==
                                                      controller.paymentMethodes
                                                          ?.paylater?[index].id
                                                          .toString()
                                                  ? kNormalAccentColor2
                                                  : kWhite,
                                              borderRadius:
                                                  AppStyle.borderRadius8All,
                                              boxShadow: [
                                                AppStyle.boxShadowSmall
                                              ]),
                                          child: Center(
                                            child: Text(
                                                controller
                                                        .paymentMethodes
                                                        ?.paylater?[index]
                                                        .name ??
                                                    '',
                                                style: controller
                                                            .selectedPayletter ==
                                                        controller
                                                            .paymentMethodes
                                                            ?.paylater?[index]
                                                            .id
                                                            .toString()
                                                    ? text10PrimaryRegular
                                                    : text10HintRegular),
                                          )),
                                    ))),
                        Gap(16.h)
                      ],
                    ),
                  ),
                ),
              ),
              Gap(72.h),
            ],
          ),
        ),
      );
    });
  }
}
