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
        return Column(
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
                            return (productSum ?? 0) + (price * (product.qty ?? 0));
                          }) ??
                          0);
                })).toString().toIdrFormat),
            _buildPaymentItem(
                'Total Ongkir',
                (controller.selectedDelivery.fold(
                        0, (sum, item) => sum + (item.packets?.rate ?? 0)))
                    .toString()
                    .toIdrFormat),
            Obx(() {
              final totalDiskon =
                  controller.totalPriceWithoutVoucher.value.toInt() -
                      controller.totalPrice.value.toInt();

              return _buildPaymentItem(
                  'Total Diskon', '-${totalDiskon.toString().toIdrFormat}');
            }),
            const SizedBox(height: 40),
          ],
        );
      }),
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
