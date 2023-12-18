import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/controllers/withdraw_status.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

class WaitingApprove extends StatelessWidget {
  const WaitingApprove({super.key, required this.controller});
  final WithdrawStatusController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(72.h),
        Center(child: SvgPicture.asset(clockLine)),
        Gap(24.h),
        Text('Penarikan Menunggu Persetujuan', style: text18BlackSemiBold),
        Gap(4.h),
        Text(
          'Mohon menunggu, pengajuan sedang dalam antrean maksimal 2 hari kerja.',
          style: text14BlackRegular,
          textAlign: TextAlign.center,
        ),
        Gap(32.h),
        SizedBox(
            width: (Get.width * 0.5).w,
            child: Obx(() {
              return AppButton.primary(
                actionStatus: controller.actionStatus.value,
                text: 'Batalkan Penarikan',
                onPressed: () => controller.cancelWithdrawConfirmation(),
              );
            }))
      ],
    );
  }
}
