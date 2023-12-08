import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/payment_register/controllers/payment_register.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import 'package:flutter/services.dart' show rootBundle;

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const Gap(270),
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: AppStyle.borderRadius20Top),
            child: GetBuilder<PaymentRegisterController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Metode Pembayaran', style: text20PrimarySemiBold),
                  Gap(4.h),
                  Text('Silakan pilih metode pembayaran.',
                      style: text14BlackRegular),
                  Gap(16.h),

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
                            Text('Bank Transfer', style: text12BlackSemiBold),
                            Visibility(
                              visible: !controller.isBankTransferExpanded,
                              child: Row(
                                  children: List.generate(
                                      controller.paymentMethodes!
                                                  .virtualAccount!.length >=
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
                                        controller
                                                .paymentMethodes
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
                                  controller.paymentMethodes?.virtualAccount
                                          ?.length ??
                                      0,
                                  (index) => GestureDetector(
                                      onTap: () => controller.actionPayment(
                                          controller.paymentMethodes
                                                  ?.virtualAccount?[index].id ??
                                              0,
                                          controller
                                                  .paymentMethodes
                                                  ?.virtualAccount?[index]
                                                  .chType ??
                                              '',
                                          controller
                                                  .paymentMethodes
                                                  ?.virtualAccount?[index]
                                                  .chCode ??
                                              '',
                                          controller
                                                  .paymentMethodes
                                                  ?.virtualAccount?[index]
                                                  .name ??
                                              ''),
                                      child: Container(
                                        height: 36.h,
                                        width: 56.w,
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                            color: controller
                                                        .selectedBankTransfer ==
                                                    controller
                                                        .paymentMethodes
                                                        ?.virtualAccount?[index]
                                                        .chCode
                                                ? kNormalAccentColor2
                                                : kWhite,
                                            border: AppStyle.borderAll,
                                            borderRadius:
                                                AppStyle.borderRadius8All,
                                            boxShadow: [
                                              AppStyle.boxShadowSmall
                                            ]),
                                        child: buildImageWidget(
                                            index,
                                            controller.assetImage(controller
                                                    .paymentMethodes
                                                    ?.virtualAccount?[index]
                                                    .chCode ??
                                                '')),
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
                                          : controller.paymentMethodes
                                                  ?.ewalletQr?.length ??
                                              0, (index) {
                                if (index == 1 &&
                                    controller.paymentMethodes!.ewalletQr!
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
                                  controller
                                          .paymentMethodes?.ewalletQr?.length ??
                                      0, (index) {
                                String assets = index ==
                                        controller.paymentMethodes!.ewalletQr!
                                                .length -
                                            1
                                    ? 'qris'
                                    : controller.paymentMethodes
                                            ?.ewalletQr?[index].chCode ??
                                        '';
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
                                                    controller
                                                        .paymentMethodes
                                                        ?.ewalletQr?[index]
                                                        .chCode &&
                                                controller.selectedchType ==
                                                    controller
                                                        .paymentMethodes
                                                        ?.ewalletQr?[index]
                                                        .chType
                                            ? kNormalAccentColor2
                                            : kWhite,
                                        border: AppStyle.borderAll,
                                        borderRadius: AppStyle.borderRadius8All,
                                        boxShadow: [AppStyle.boxShadowSmall]),
                                    child: buildImageWidget(
                                        index, controller.assetImage(assets)),
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
                                      controller.paymentMethodes!.otc!.length >=
                                              3
                                          ? 3
                                          : controller.paymentMethodes!.otc!
                                              .length, (index) {
                                if (index == 2 &&
                                    controller.paymentMethodes!.otc!.length >
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
                                    decoration: BoxDecoration(
                                        color: kWhite,
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
                                                                .chCode
                                                        ? kNormalAccentColor2
                                                        : kWhite,
                                                borderRadius:
                                                    AppStyle.borderRadius8All,
                                                boxShadow: [
                                                  AppStyle.boxShadowSmall
                                                ]),
                                            child: buildImageWidget(
                                                index,
                                                controller.assetImage(controller
                                                        .paymentMethodes
                                                        ?.otc?[index]
                                                        .chCode ??
                                                    '')),
                                          ),
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
            }),
          ),
        ],
      ),
    ));
  }

  Future<bool> checkAssetImageExists(String assetImagePath) async {
    try {
      ByteData imageData = await rootBundle.load(assetImagePath);
      return imageData.lengthInBytes != 0;
    } catch (e) {
      print('Error checking asset image: $e');
      return false;
    }
  }

  Widget buildImageWidget(int index, String assetImagePath) {
    return FutureBuilder<bool>(
      future: checkAssetImageExists(assetImagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasData && snapshot.data == true) {
          return Image.asset(
            assetImagePath,
            fit: BoxFit.contain,
            height: 24.h,
            width: 44.w,
          );
        } else {
          return buildErrorContainer();
        }
      },
    );
  }

  Widget buildErrorContainer() {
    return SizedBox(
      width: 44.w,
      height: 24.h,
      child: Center(
          child: Icon(
        Icons.warning_rounded,
        color: kPrimaryColor,
        size: 16.r,
      )),
    );
  }
}
