import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/pinjaman/controllers/pinjaman.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class ChoiceLoanSection extends StatelessWidget {
  const ChoiceLoanSection({super.key, required this.controller});

  final PinjamanController controller;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        padding: AppStyle.paddingAll16,
        itemCount: controller.choiceLoan.length,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => controller.actionChoice(index),
          child: Container(
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
                borderRadius: AppStyle.borderRadius8All,
                color: kWhite,
                boxShadow: [AppStyle.boxShadow]),
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: CircleAvatar(
                  backgroundColor: kSecondaryColor2,
                  radius: 22.r,
                  child: SvgPicture.asset(
                    controller.choiceLoan[index]['icon'],
                  ),
                ),
                title: Text(controller.choiceLoan[index]['title'],
                    style: text14BlackRegular)),
          ),
        ),
        separatorBuilder: (_, i) => Gap(12.h),
      ),
    );
  }
}
