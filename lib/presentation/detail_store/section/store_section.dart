import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: AppStyle.borderRadius8All,
            color: kWhite,
            border: AppStyle.borderAll,
            boxShadow: [AppStyle.boxShadowSmall]),
        child: Column(
          children: [
            ListTile(
              contentPadding: AppStyle.paddingAll8,
              leading: CircleAvatar(
                radius: 26.r,
                backgroundColor: kPrimaryColor2,
              ),
              title: Text('Stationary’s', style: text14BlackMedium),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: kSuccessColor,
                    size: 8.r,
                  ),
                  Gap(4.w),
                  Text('Online', style: text11SuccessRegular),
                ],
              ),
              trailing: SizedBox(
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded,
                            color: kWarningColor, size: 20.r),
                        Gap(4.w),
                        Text('4.4', style: text16BlackSemiBold)
                      ],
                    ),
                    Text('Rating & Ulasan', style: text12HintRegular)
                  ],
                ),
              ),
            ),
            Divider(
              color: kDivider,
              height: 0,
              thickness: 1,
            ),
            Gap(12.h),
            Padding(
              padding: AppStyle.paddingSide12,
              child: Row(
                children: [
                  SvgPicture.asset(pinMapLine),
                  Gap(8.w),
                  Text('2118 Thornridge Cir. Syracuse, Connecticut 35624',
                      style: text11GreyRegular),
                  Gap(8.w),
                  SvgPicture.asset(editLine)
                ],
              ),
            ),
            Gap(8.h),
            Padding(
              padding: AppStyle.paddingSide12,
              child: Row(
                children: [
                  SvgPicture.asset(timeLine),
                  Gap(8.w),
                  Text('Setiap Hari (09:00 - 23:00 WIB)',
                      style: text11GreyRegular),
                ],
              ),
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
