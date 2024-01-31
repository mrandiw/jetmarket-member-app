import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../controllers/withdraw_status.controller.dart';

class CancelWithdraw extends StatelessWidget {
  const CancelWithdraw({super.key, required this.controller});
  final WithdrawStatusController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(72.h),
        Center(child: SvgPicture.asset(doneLine)),
        Gap(24.h),
        Text('Withdraw Berhasil Dibatalkan', style: text18BlackSemiBold),
        Gap(4.h),
        Text(
          'Pengajuan penarikan dana telah dibatalkan.',
          style: text14BlackRegular,
          textAlign: TextAlign.center,
        ),
        Gap(32.h),
        SizedBox(
            width: (Get.width * 0.5).w,
            child: Obx(() {
              return AppButton.primary(
                actionStatus: controller.actionStatus.value,
                text: 'Kembali ke Beranda',
                onPressed: () => controller.refreshEwalletPage(),
              );
            }))
      ],
    );
  }
}
