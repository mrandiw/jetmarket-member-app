import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan_manual/controllers/add_tabungan_manual.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';

class TotalSection extends StatelessWidget {
  const TotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTabunganManualController>(
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
