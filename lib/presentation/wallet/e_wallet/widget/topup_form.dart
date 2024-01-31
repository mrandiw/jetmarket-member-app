import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';

import '../../../../components/form/app_form_nominal.dart';
import '../../../../components/formatter/nominal_formatter.dart';

class TopUpForm extends StatelessWidget {
  const TopUpForm({super.key, required this.controller});
  final EWalletController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppBottomSheet(
        title: '',
        textButton: 'Bayar',
        onPressed: controller.isNominalValue.isTrue
            ? () => controller.toPaymentTopup()
            : null,
        gapBottom: 72.h,
        child: content,
      );
    });
  }

  Widget get content {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Silahkan Masukan Nominal Topup', style: text14BlackSemiBold),
        Gap(16.h),
        AppFormNominal(
          controller: controller.nominalController,
          onChanged: controller.listenNominalForm,
          inputFormatters: [NominalFormatter()],
        ),
      ],
    );
  }
}
