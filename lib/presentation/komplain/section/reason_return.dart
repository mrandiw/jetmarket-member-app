import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/komplain/controllers/komplain.controller.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/assets/assets_svg.dart';
import '../../../utils/style/app_style.dart';

class ReasonReturn extends StatelessWidget {
  const ReasonReturn({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KomplainController>(builder: (controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Alasan pengembalian', style: text14BlackMedium),
        Gap(10.h),
        Container(
          height: 44.h,
          padding: AppStyle.paddingSide12,
          decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll),
          child: DropdownButton(
            value: controller.selectedReason,
            underline: const SizedBox.shrink(),
            isExpanded: true,
            style: text12BlackRegular,
            icon: SvgPicture.asset(
              arrowDown,
              colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
            ),
            items: controller.reasonReturn
                .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: text12BlackRegular,
                    )))
                .toList(),
            onChanged: (value) => controller.changeReasonReturn(value ?? ''),
          ),
        ),
      ]);
    });
  }
}
