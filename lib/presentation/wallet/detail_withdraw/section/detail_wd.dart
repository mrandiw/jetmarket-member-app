import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/controllers/detail_withdraw.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
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
          StatusWdCard(
              type: type(controller.detailWithdrawModel?.status ?? ''),
              title: controller.detailWithdrawModel?.pinnedNote?.title ?? '',
              subtitle:
                  controller.detailWithdrawModel?.pinnedNote?.description ??
                      ''),
          Gap(16.h),
          Text('Informasi Penarikan', style: text14BlackMedium),
          Gap(12.h),
          Text('Tanggal Pengajuan', style: text12HintRegular),
          Gap(6.h),
          Text(
              controller.detailWithdrawModel?.withdrawData?.createdAt
                      ?.convertToCustomFormat ??
                  '',
              style: text12BlackRegular),
          Gap(6.h),
          Visibility(
              visible: controller.detailWithdrawModel?.status == 'SUCCESED',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terakhir Update', style: text12HintRegular),
                  Gap(6.h),
                  Text(
                      controller.detailWithdrawModel?.withdrawData?.updatedAt
                              ?.convertToCustomFormat ??
                          '',
                      style: text12BlackRegular),
                  Gap(6.h),
                ],
              )),
          Text('Nominal Penarikan', style: text12HintRegular),
          Gap(6.h),
          Text(
              "${controller.detailWithdrawModel?.withdrawData?.amount}"
                  .toIdrFormat,
              style: text12BlackSemiBold),
          Gap(6.h),
          Text(
              controller.detailWithdrawModel?.status == 'SUCCESED'
                  ? 'Dikirim keRekening'
                  : 'No Rekening',
              style: text12HintRegular),
          Gap(6.h),
          Text(
              '${controller.detailWithdrawModel?.withdrawData?.bank} - ${controller.detailWithdrawModel?.withdrawData?.rekening}',
              style: text12BlackSemiBold),
        ],
      );
    });
  }

  StatusWdType type(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return StatusWdType.waiting;
      case 'CANCELLED':
        return StatusWdType.failed;
      default:
        return StatusWdType.success;
    }
  }
}
