import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Alamat Pengiriman', style: text14BlackMedium),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.EDIT_ADDRESS),
                    child: Text('Ubah', style: text12NormalRegular))
              ],
            ),
            Row(
              children: [
                Text('Rumah', style: text12HintRegular),
                Gap(8.w),
                Container(
                  padding: AppStyle.paddingAll8,
                  decoration: BoxDecoration(
                      borderRadius: AppStyle.borderRadius6All,
                      color: kPrimaryColor2),
                  child:
                      Center(child: Text('Utama', style: text11PrimaryRegular)),
                )
              ],
            ),
            Gap(6.h),
            Row(
              children: [
                Text('John Doe', style: text12HintRegular),
                Gap(8.w),
                Text('(+62) 8789096367', style: text12HintRegular),
              ],
            ),
            Gap(6.h),
            Text('2118 Thornridge Cir. Syracuse, Connecticut 35624',
                style: text12HintRegular),
          ],
        ));
  }
}
