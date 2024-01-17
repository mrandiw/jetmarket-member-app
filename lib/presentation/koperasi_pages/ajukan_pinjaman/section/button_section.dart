import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan/controllers/add_tabungan.controller.dart';
import 'package:jetmarket/presentation/koperasi_pages/ajukan_pinjaman/controllers/ajukan_pinjaman.controller.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AjukanPinjamanController>(builder: (controller) {
      return Container(
        height: 76.h,
        width: Get.width,
        padding: AppStyle.paddingAll16,
        decoration: BoxDecoration(color: kWhite, boxShadow: [
          BoxShadow(
              color: const Color(0xffE3BEBD).withOpacity(0.08),
              offset: const Offset(0, -6),
              blurRadius: 10)
        ]),
        child: AppButton.primary(
          actionStatus: controller.actionStatus,
          text: 'Kirim Pengajuan',
          onPressed: controller.isNameRek &&
                  controller.isAddress &&
                  controller.isKtp &&
                  controller.isNoRek &&
                  controller.isName &&
                  controller.isNominalPinjaman &&
                  controller.selectedRekening != null &&
                  controller.imageUrl != null
              ? () => controller.submitPinjaman()
              : null,
        ),
      );
    });
  }
}
