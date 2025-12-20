import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingSide16,
      child: GetBuilder<CheckoutController>(builder: (controller) {
        return Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rincian Pembayaran', style: text14BlackMedium),
              _buildPaymentItem(
                  'Total Barang',
                  (controller.productCart.fold(0, (sum, cartProduct) {
                    return sum +
                        (cartProduct.products?.fold(0, (productSum, product) {
                              final price =
                                  (product.promo != null && product.promo != 0)
                                      ? product.promo!
                                      : (product.price ?? 0);
                              return (productSum ?? 0) +
                                  (price * (product.qty ?? 0));
                            }) ??
                            0);
                  })).toString().toIdrFormat),

              // Ongkir section - Use V2 rate for JET if available, otherwise V1
              _buildOngkirHybrid(controller),

              // Diskon section
              Builder(builder: (context) {
                final totalDiskon =
                    controller.totalPriceWithoutVoucher.value.toInt() -
                        controller.totalPrice.value.toInt();

                return _buildPaymentItem(
                    'Total Diskon', '-${totalDiskon.toString().toIdrFormat}');
              }),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  /// HYBRID: Calculate ongkir from V1 selectedDelivery, BUT use V2 rate for JET if available
  Widget _buildOngkirHybrid(CheckoutController controller) {
    int totalOngkir = 0;

    // Loop through selectedDelivery (V1) but override rate for JET with V2
    for (var item in controller.selectedDelivery) {
      int sellerId = item.sellerId ?? 0;
      int rate = item.packets?.rate ?? 0;

      // If JET courier and V2 result exists, use V2 rate instead
      if (item.packets?.delivery?.code == 'jet' &&
          controller.ongkirV2Results.containsKey(sellerId)) {
        rate = controller.ongkirV2Results[sellerId]?.pricing?.rate ?? rate;
      }

      totalOngkir += rate;
    }

    return _buildPaymentItem(
      'Total Ongkir',
      totalOngkir.toString().toIdrFormat,
    );
  }

  Widget _buildOngkirV2(CheckoutController controller) {
    int totalOngkir = 0;
    bool hasGratisOngkir = false;
    List<Widget> ongkirDetails = [];

    // Calculate total dan build details untuk tiap seller
    for (var cartProduct in controller.productCart) {
      int sellerId = cartProduct.seller?.id ?? 0;
      var ongkirInfo = controller.ongkirV2Results[sellerId];

      if (ongkirInfo != null) {
        totalOngkir += ongkirInfo.pricing?.rate ?? 0;

        // FIX: Check BOTH isFreeOngkir AND isEligibleFreeOngkir
        final isActuallyFree = ongkirInfo.pricing?.isFreeOngkir == true &&
            ongkirInfo.pricing?.isEligibleFreeOngkir == true;

        if (isActuallyFree) {
          hasGratisOngkir = true;
        }

        // Detail per seller
        String sellerName = cartProduct.seller?.name ?? 'Seller';
        String rate = (ongkirInfo.pricing?.rate ?? 0).toString().toIdrFormat;
        String tierName = ongkirInfo.pricing?.tierName ?? '';

        ongkirDetails.add(
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '$sellerName ($tierName)',
                    style: text12HintRegular,
                  ),
                ),
                Row(
                  children: [
                    // FIX: Only show GRATIS badge if actually eligible
                    if (isActuallyFree)
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'GRATIS',
                          style: text10SuccessMedium,
                        ),
                      ),
                    Text(
                      rate,
                      style: text12HintRegular,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPaymentItem(
          'Total Ongkir',
          totalOngkir.toString().toIdrFormat,
        ),
        ...ongkirDetails,
        if (hasGratisOngkir)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4),
            child: Text(
              '🎉 Gratis ongkir tersedia!',
              style: text12HintRegular.copyWith(color: Colors.green[700]),
            ),
          ),
      ],
    );
  }

  Widget _buildPaymentItem(String title, String value) {
    return Row(children: [
      Expanded(child: Text(title, style: text14BlackRegular)),
      Expanded(
          child: Text(
        value,
        style: text14BlackRegular,
        textAlign: TextAlign.right,
      )),
    ]);
  }
}
