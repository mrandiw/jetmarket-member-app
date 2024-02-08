import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ChoiceOption extends StatelessWidget {
  const ChoiceOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Container(
        padding: AppStyle.paddingAll12,
        decoration: BoxDecoration(
            borderRadius: AppStyle.borderRadius8All,
            color: kWhite,
            boxShadow: [AppShadow.boxShadow]),
        child: Column(
          children: [
            ListTile(
              onTap: () => Get.toNamed(Routes.ADD_TABUNGAN),
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: CircleAvatar(
                  backgroundColor: kSecondaryColor2,
                  radius: 22.r,
                  child: SvgPicture.asset(
                    paymentClock,
                    colorFilter:
                        const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  )),
              title: Text('Tabungan Otomatis', style: text12BlackMedium),
              subtitle: Text(
                  'Atur tabungan terjadwal, tagihan otomatis potong melalui gaji',
                  style: text11GreyRegular),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16.r),
            ),
            Gap(8.hr),
            ListTile(
              onTap: () => Get.toNamed(Routes.ADD_TABUNGAN_MANUAL),
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: CircleAvatar(
                  backgroundColor: kSecondaryColor2,
                  radius: 22.r,
                  child: SvgPicture.asset(
                    paymentClock,
                    colorFilter:
                        const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  )),
              title: Text('Tabungan Manual', style: text12BlackMedium),
              subtitle: Text('Menabung kapan saja melalui saldo ewallet',
                  style: text11GreyRegular),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16.r),
            )
          ],
        ),
      ),
    );
  }
}
