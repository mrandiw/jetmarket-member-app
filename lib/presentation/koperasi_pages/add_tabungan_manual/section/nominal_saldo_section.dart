import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan_manual/controllers/add_tabungan_manual.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../components/form/app_form_nominal.dart';
import '../../../../components/formatter/nominal_formatter.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class NominalSaldoSection extends StatelessWidget {
  const NominalSaldoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTabunganManualController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nominal', style: text12BlackRegular),
          Gap(8.hr),
          AppFormNominal(
            controller: controller.nominalController,
            onChanged: controller.listenNominalForm,
            inputFormatters: [NominalFormatter()],
          ),
          Gap(20.hr),
          Text('Pilih Metode Pembayaran', style: text12BlackRegular),
          Gap(12.hr),
          GestureDetector(
            onTap: () => controller.confirmationDialogSavingSaldo(),
            child: Container(
              height: 60.hr,
              width: Get.width.wr,
              padding: AppStyle.paddingAll12,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.savingPaymentMethode?.saldo?.title ?? '',
                      style: text12BlackRegular),
                  Text(
                      'Saldo :${'${controller.savingPaymentMethode?.saldo?.total}'.toIdrFormat}',
                      style: text12NormalRegular)
                ],
              ),
            ),
          ),
          Gap(12.hr),
        ],
      );
    });
  }
}
