import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon(
      {super.key, this.onTap, required this.title, required this.icon});

  final Function()? onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius6All,
              boxShadow: [AppStyle.boxShadow],
            ),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 18.r,
                    backgroundColor: kPrimaryColor2,
                    child: Center(
                      child: SvgPicture.asset(icon),
                    )),
                Gap(8.wr),
                Text(title, style: text14BlackRegular)
              ],
            )));
  }
}
