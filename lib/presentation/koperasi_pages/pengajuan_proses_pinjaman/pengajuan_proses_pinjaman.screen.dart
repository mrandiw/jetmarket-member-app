import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../utils/assets/assets_svg.dart';
import 'controllers/pengajuan_proses_pinjaman.controller.dart';

class PengajuanProsesPinjamanScreen
    extends GetView<PengajuanProsesPinjamanController> {
  const PengajuanProsesPinjamanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.hr, horizontal: 32.wr),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset(warningProccess)),
          Gap(32.hr),
          Text('Pengajuan Terkirim', style: text20PrimarySemiBold),
          Gap(8.hr),
          Text('Mohon menunggu. Admin akan memproses pengajuan pinjaman Kamu.',
              textAlign: TextAlign.center, style: text14BlackRegular),
          Gap(32.hr),
          AppButton.secondary(
            text: 'Batalkan Pengajuan',
            onPressed: () => controller.confirmationCancel(),
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
