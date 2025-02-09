import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../controllers/choice_payment_tagihan.controller.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoicePaymentTagihanController>(
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              _buildPaymentItem(
                'Biaya Layanan',
                controller.calculateSelectedPricing(),
              ),
              _buildPaymentItem(
                'Total Tagihan',
                (Get.arguments != null ? Get.arguments[1] : 0)
                    .toString()
                    .toIdrFormat,
              ),
              _buildPaymentItem(
                'Total Pembayaran',
                controller.calculateTotalPayment().toIdrFormat,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentItem(String title, String value) {
    return Row(children: [
      Expanded(child: Text(title, style: text12BlackRegular)),
      Expanded(
          child: Text(value,
              style: text14BlackSemiBold, textAlign: TextAlign.right)),
    ]);
  }
}
