import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan_manual/controllers/add_tabungan_manual.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTabunganManualController>(builder: (controller) {
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
          actionStatus: controller.actionButton,
          text: 'Submit',
          onPressed: controller.selectedChCode != null
              ? () => controller.savingDirect()
              : null,
        ),
      );
    });
  }
}
