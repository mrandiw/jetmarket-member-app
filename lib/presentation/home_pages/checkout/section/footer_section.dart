import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (controller) {
      return Container(
        height: 88.h,
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius20Top,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffE3BEBD).withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -6))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total Pembayaran', style: text14HintRegular),
                Text('${controller.totalPrice.toInt()}'.toIdrFormat,
                    style: text14PrimarySemiBold),
                Visibility(
                  visible: controller.discount > 0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                        '${controller.totalPriceWithoutVoucher.toInt()}'
                            .toIdrFormat,
                        style: text10lineThroughRegular),
                  ),
                ),
              ],
            )),
            AppButton.primary(
              text: 'Bayar Sekarang',
              onPressed: _isButtonEnabled(controller)
                  ? () => controller.toChoicePayment()
                  : null,
            ),
          ],
        ),
      );
    });
  }

  /// Check if button should be enabled
  /// Hybrid logic: All couriers must be selected (V1), plus V2 validation for JET
  bool _isButtonEnabled(CheckoutController controller) {
    // 1. Check if all sellers have selected delivery (V1)
    if (controller.selectedDelivery.length != controller.productCart.length) {
      return false;
    }

    // 2. For sellers with JET selected, check V2 requirements
    for (var selected in controller.selectedDelivery) {
      if (selected.packets?.delivery?.code == 'jet') {
        int sellerId = selected.sellerId ?? 0;

        // Check if V2 ongkir check is completed for this JET courier
        var isLoading = controller.ongkirV2Loading[sellerId] ?? false;
        var hasError = controller.ongkirV2Errors[sellerId] != null;
        var hasResult = controller.ongkirV2Results.containsKey(sellerId);

        if (isLoading || hasError || !hasResult) {
          return false; // JET V2 not ready yet
        }

        // If free ongkir, check time slot selected
        var ongkirInfo = controller.ongkirV2Results[sellerId];
        if (ongkirInfo?.pricing?.requireTimeSlot == true) {
          if (controller.selectedTimeSlots[sellerId] == null) {
            return false; // Time slot required but not selected
          }
        }
      }
    }

    return true;
  }
}
