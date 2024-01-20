import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../components/button/app_button.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/assets/assets_svg.dart';
import 'controllers/payment_tabungan_success.controller.dart';

class PaymentTabunganSuccessScreen
    extends GetView<PaymentTabunganSuccessController> {
  const PaymentTabunganSuccessScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.hr, horizontal: 32.wr),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset(monayBag)),
          Gap(32.hr),
          Text('Pembayaran Berhasil', style: text20PrimarySemiBold),
          Gap(8.hr),
          Text('Nominal sebesar Rp100.000 berhasil ditambahkan ke tabunganmu',
              textAlign: TextAlign.center, style: text14BlackRegular),
          Gap(32.hr),
          AppButton.primary(
            text: 'Lihat Rincian',
            onPressed: () => Get.offNamed(Routes.DETAIL_MENABUNG,
                arguments: controller.savingDirect?.savingId),
          ),
          Gap(12.hr),
          AppButton.secondaryGrey(
            text: 'Kembali',
            onPressed: () => Get.back(),
          )
        ],
      ),
    ));
  }
}
