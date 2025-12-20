import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class DeliveryItem extends StatelessWidget {
  const DeliveryItem(
      {super.key,
      required this.data,
      required this.sellerId,
      required this.isExpandedTile,
      this.onExpansionChanged,
      required this.indexDelivery,
      this.excontroller});

  final List<DeliveryModel> data;
  final int sellerId;
  final bool isExpandedTile;
  final Function(bool)? onExpansionChanged;
  final int indexDelivery;
  final ExpansionTileController? excontroller;

  @override
  Widget build(BuildContext context) {
    // Get controller to access V2 results
    final controller = Get.find<CheckoutController>();

    return Column(
      children: [
        SizedBox(
          width: Get.width.wr,
          child: Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                highlightColor: kWhite,
                hoverColor: kWhite,
                focusColor: kWhite,
                splashColor: kWhite),
            child: ExpansionTile(
              title: Text(
                'Pengiriman',
                style: text12BlackSemiBold,
              ),
              iconColor: kBlack,
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: isExpandedTile,
              onExpansionChanged: onExpansionChanged,
              maintainState: isExpandedTile,
              controller: excontroller,
              children: [
                Container(
                  width: Get.width.wr,
                  padding: AppStyle.paddingAll8,
                  decoration: BoxDecoration(
                    color: kBorder,
                    borderRadius: AppStyle.borderRadius8All,
                  ),
                  child: Column(
                    children: data
                        .where((delivery) => delivery.sellerId == sellerId)
                        .map((delivery) => Column(
                                children: List.generate(
                                    delivery.services?.length ?? 0, (index) {
                              // Get the actual rate - use V2 if JET courier
                              final service = delivery.services?[index];
                              final isJetCourier = service?.packets
                                      ?.any((p) => p.delivery?.code == 'jet') ??
                                  false;

                              int displayRate = service?.rate ?? 0;

                              // Get V2 info for JetKurir promo badge
                              final v2Result =
                                  controller.ongkirV2Results[sellerId];
                              final isEligibleFreeOngkir =
                                  v2Result?.pricing?.isEligibleFreeOngkir ??
                                      true;
                              final isInFreeOngkirRange =
                                  v2Result?.pricing?.isInFreeOngkirRange ??
                                      false;
                              final minPurchaseText =
                                  v2Result?.pricing?.minPurchaseText ?? '';

                              // If JET courier and V2 result exists, use V2 rate
                              if (isJetCourier &&
                                  controller.ongkirV2Results
                                      .containsKey(sellerId)) {
                                displayRate = controller
                                        .ongkirV2Results[sellerId]
                                        ?.pricing
                                        ?.rate ??
                                    displayRate;
                              }

                              // Show promo badge if: JET + not eligible + in free range
                              final showPromoBadge = isJetCourier &&
                                  !isEligibleFreeOngkir &&
                                  isInFreeOngkirRange &&
                                  minPurchaseText.isNotEmpty;

                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppStyle.borderRadius8All,
                                ),
                                color: kWhite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        List<dynamic>? packets =
                                            delivery.services?[index].packets;
                                        String packetsJson =
                                            jsonEncode(packets);
                                        Get.toNamed(Routes.CHOICE_DELIVERY,
                                            arguments: [
                                              sellerId,
                                              packetsJson,
                                              indexDelivery
                                            ]);
                                      },
                                      contentPadding: AppStyle.paddingSide12,
                                      visualDensity: VisualDensity.compact,
                                      dense: true,
                                      title: Text(
                                          '${'${service?.name}'.toUpperCase()} (${displayRate.toString().toIdrFormat})',
                                          style: text12BlackRegular),
                                      subtitle: Text(
                                        '${service?.duration}',
                                        style: text12HintRegular,
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14.wr,
                                      ),
                                    ),
                                    // Promo badge for free ongkir
                                    if (showPromoBadge)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12, bottom: 8),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color:
                                                kSuccessColor.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: kSuccessColor
                                                    .withOpacity(0.3)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.local_offer,
                                                  size: 12,
                                                  color: kSuccessColor),
                                              const SizedBox(width: 4),
                                              Flexible(
                                                child: Text(
                                                  'Belanja min. $minPurchaseText untuk GRATIS Ongkir!',
                                                  style: text10BlackRegular
                                                      .copyWith(
                                                          color: kSuccessColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            })))
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
