import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/controllers/choice_delivery.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class PacketItem extends StatelessWidget {
  const PacketItem(
      {super.key,
      required this.index,
      required this.data,
      this.onTap,
      required this.sellerId});

  final int index;
  final Packets data;
  final Function()? onTap;
  final int sellerId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoiceDeliveryController>(builder: (controller) {
      // Get CheckoutController to access V2 results
      final checkoutController = Get.find<CheckoutController>();

      // Determine actual rate - use V2 if JET courier
      final isJetCourier = data.delivery?.code == 'jet';
      int displayRate = data.rate ?? 0;

      // Get V2 info for JetKurir promo badge
      final v2Result = checkoutController.ongkirV2Results[sellerId];
      final isEligibleFreeOngkir =
          v2Result?.pricing?.isEligibleFreeOngkir ?? true;
      final isInFreeOngkirRange =
          v2Result?.pricing?.isInFreeOngkirRange ?? false;
      final minPurchaseText = v2Result?.pricing?.minPurchaseText ?? '';

      if (isJetCourier &&
          checkoutController.ongkirV2Results.containsKey(sellerId)) {
        displayRate =
            checkoutController.ongkirV2Results[sellerId]?.pricing?.rate ??
                displayRate;
      }

      // Show promo badge if: JET + not eligible + in free range
      final showPromoBadge = isJetCourier &&
          !isEligibleFreeOngkir &&
          isInFreeOngkirRange &&
          minPurchaseText.isNotEmpty;

      return Card(
        elevation: 0,
        margin: AppStyle.paddingBottom8,
        color: kWhite,
        shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: onTap,
              contentPadding: AppStyle.paddingSide12,
              title: Text(
                  "${data.name} (${displayRate.toString().toIdrFormat})",
                  style: text12BlackRegular),
              subtitle: Text(
                '${data.duration}',
                style: text12HintRegular,
              ),
              trailing: SizedBox(
                width: 26.w,
                child: RadioListTile(
                    activeColor: kPrimaryColor,
                    fillColor: WidgetStateProperty.all(
                        controller.selectedPacket == index
                            ? kPrimaryColor
                            : kDivider),
                    value: index,
                    selected: controller.selectedPacket == index,
                    groupValue: controller.selectedPacket,
                    onChanged: (value) => controller.selectPacket(value!)),
              ),
            ),
            // Promo badge for free ongkir
            if (showPromoBadge)
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kSuccessColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kSuccessColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_offer, size: 12, color: kSuccessColor),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Belanja min. $minPurchaseText untuk GRATIS Ongkir!',
                          style:
                              text10BlackRegular.copyWith(color: kSuccessColor),
                        ),
                      ),
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
