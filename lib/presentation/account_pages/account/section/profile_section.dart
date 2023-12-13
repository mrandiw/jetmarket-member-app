import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/account_pages/account/controllers/account.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.controller});

  final AccountController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppStyle.paddingAll16,
      leading: CircleAvatar(radius: 26.r, backgroundColor: kPrimaryColor2),
      title: Text(controller.userData?.user?.name ?? '-',
          style: text12BlackMedium),
      subtitle: Text(controller.userData?.user?.email ?? '-',
          style: text12HintRegular),
      trailing: GestureDetector(
        onTap: () =>
            Get.toNamed(Routes.EDIT_ACCOUNT, arguments: controller.userData),
        child: SvgPicture.asset(
          editLine,
          colorFilter: const ColorFilter.mode(kBlack, BlendMode.srcIn),
          height: 14.r,
          width: 14.r,
        ),
      ),
    );
  }
}
