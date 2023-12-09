import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/account/controllers/account.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingVert12,
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              contentPadding: AppStyle.paddingSide16,
              leading: Container(
                height: 28.r,
                width: 28.r,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: AppStyle.borderRadius6All),
                child: SvgPicture.asset(voucherLine),
              ),
              title: Text('Kode Referral', style: text12BlackMedium),
              subtitle: Text('Bagikan kode, tukarkan dengan saldo',
                  style: text12HintRegular),
              trailing: SvgPicture.asset(
                arrowRight,
                height: 11.h,
                width: 7.w,
              ),
            ),
            Gap(12.h),
            ListTile(
              onTap: () {},
              contentPadding: AppStyle.paddingSide16,
              leading: Container(
                height: 28.r,
                width: 28.r,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: AppStyle.borderRadius6All),
                child: SvgPicture.asset(reviewLine),
              ),
              title: Text('Review Produk', style: text12BlackMedium),
              subtitle: Text('Berikan review produk', style: text12HintRegular),
              trailing: SvgPicture.asset(
                arrowRight,
                height: 11.h,
                width: 7.w,
              ),
            ),
            Gap(12.h),
            Padding(
              padding: AppStyle.paddingSide16,
              child: Divider(
                color: kBorder,
                height: 0,
              ),
            ),
            Gap(12.h),
            ListTile(
              onTap: () => controller.confirmationLogout(),
              contentPadding: AppStyle.paddingSide16,
              leading: Container(
                height: 28.r,
                width: 28.r,
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: AppStyle.borderRadius6All),
                child: SvgPicture.asset(logout),
              ),
              title: Text('Logout', style: text12BlackMedium),
              trailing: SvgPicture.asset(
                arrowRight,
                height: 11.h,
                width: 7.w,
              ),
            ),
          ],
        ));
  }
}
