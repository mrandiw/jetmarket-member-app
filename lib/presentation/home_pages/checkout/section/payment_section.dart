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

              // Ongkir section - V1 or V2
              if (controller.useOngkirV2.value)
                _buildOngkirV2(controller)
              else
                _buildPaymentItem(
                    'Total Ongkir',
                    (controller.selectedDelivery.fold(
                            0, (sum, item) => sum + (item.packets?.rate ?? 0)))
                        .toString()
                        .toIdrFormat),

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

        if (ongkirInfo.pricing?.isFreeOngkir == true) {
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
                    if (ongkirInfo.pricing?.isFreeOngkir == true)
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
