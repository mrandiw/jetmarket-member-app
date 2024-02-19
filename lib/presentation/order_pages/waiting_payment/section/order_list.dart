import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/waiting_payment/controllers/waiting_payment.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaitingPaymentController>(builder: (controller) {
      return ListView.builder(
          padding: AppStyle.paddingAll16,
          itemCount: controller.waitingPayment.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: AppStyle.paddingBottom8,
              child: GestureDetector(
                onTap: () => controller
                    .toListOrder(controller.waitingPayment[index].refId ?? ''),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All,
                      side: AppStyle.borderSide),
                  child: Padding(
                    padding: AppStyle.paddingAll12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          SvgPicture.asset(timeLine),
                          Gap(8.w),
                          Text(
                            'Bayar Sebelum',
                            style: text12BlackRegular,
                          ),
                          const Spacer(),
                          Text(
                              '${controller.waitingPayment[index].expiredAt?.split('.').first.formatDate}',
                              style: text12WarningMedium)
                        ]),
                        Gap(8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${controller.waitingPayment[index].paymentInfo?.code} ${controller.waitingPayment[index].paymentInfo?.name == 'VIRTUAL_ACCOUNT' ? 'Virtual Account' : ''}",
                                style: text12BlackMedium),
                            Image.asset(
                              controller.assetImage(controller
                                      .waitingPayment[index]
                                      .paymentInfo
                                      ?.code ??
                                  ''),
                              height: 14.h,
                            )
                          ],
                        ),
                        Gap(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Pembayaran:',
                                      style: text10BlackRegular),
                                  Gap(4.h),
                                  Text(
                                      "${controller.waitingPayment[index].amount}"
                                          .toIdrFormat,
                                      style: text16PrimarySemiBold),
                                ]),
                            AppButton.secondarySmall(
                              text: 'Lihat Cara Bayar',
                              onPressed: () => controller.toCaraBayar(
                                  controller.waitingPayment[index].id ?? 0),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
