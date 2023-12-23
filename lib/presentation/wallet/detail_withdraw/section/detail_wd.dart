import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/controllers/detail_withdraw.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../widget/status_wd_card.dart';

class DetailWd extends StatelessWidget {
  const DetailWd({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailWithdrawController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          StatusWdCard(type: controller.statusWd),
          Gap(16.h),
          Text('Informasi Anggota', style: text14BlackMedium),
          Gap(12.h),
          Text('Nama Lengkap', style: text12HintRegular),
          Gap(6.h),
          Text('Jhon doe', style: text12BlackRegular),
          Gap(6.h),
          Text('No. KTP', style: text12HintRegular),
          Gap(6.h),
          Text('32000987654321', style: text12BlackRegular),
          Gap(20.h),
          Text('Informasi Penarikan', style: text14BlackMedium),
          Gap(12.h),
          Text('Tanggal Pengajuan', style: text12HintRegular),
          Gap(6.h),
          Text('31 Nov 2023 12:34', style: text12BlackRegular),
          Gap(6.h),
          Visibility(
              visible: controller.statusWd == StatusWdType.success,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal Persetujuan', style: text12HintRegular),
                  Gap(6.h),
                  Text('31 Nov 2023 16:10', style: text12BlackRegular),
                  Gap(6.h),
                ],
              )),
          Text('Nominal Penarikan', style: text12HintRegular),
          Gap(6.h),
          Text('Rp1.000.000', style: text12BlackSemiBold),
          Gap(6.h),
          Text(
              controller.statusWd == StatusWdType.success
                  ? 'Dikirim ke Rekening'
                  : 'No Rekening',
              style: text12HintRegular),
          Gap(6.h),
          Text('BCA - 009827642233', style: text12BlackSemiBold),
        ],
      );
    });
  }
}
