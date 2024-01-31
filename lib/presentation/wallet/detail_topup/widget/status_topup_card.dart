import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_topup.controller.dart';

class StatusTopupCard extends StatelessWidget {
  const StatusTopupCard(
      {super.key,
      this.type = StatusTopupType.success,
      this.title = '',
      this.subtitle = ''});

  final StatusTopupType type;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: AppStyle.paddingAll16,
          width: Get.width,
          decoration: BoxDecoration(
            color: _bgColor(type),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            border: Border.all(color: kBorder, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon(type)),
              Gap(8.w),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: text12BlackMedium),
                      Gap(4.h),
                      Text(subtitle, style: text12HintRegular)
                    ]),
              )
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 3,
            decoration: BoxDecoration(
              color: _borderColor(type),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _borderColor(StatusTopupType type) {
    switch (type) {
      case StatusTopupType.success:
        return kSuccessColor;
      case StatusTopupType.failed:
        return kPrimaryColor;
      default:
        return kWarningColor;
    }
  }

  Color _bgColor(StatusTopupType type) {
    switch (type) {
      case StatusTopupType.success:
        return kSuccessColor2.withOpacity(0.4);
      case StatusTopupType.failed:
        return kPrimaryColor2.withOpacity(0.4);
      default:
        return kWarningColor.withOpacity(0.06);
    }
  }

  String icon(StatusTopupType type) {
    switch (type) {
      case StatusTopupType.success:
        return dbSuccess;
      case StatusTopupType.failed:
        return dbError;
      default:
        return dbWarning;
    }
  }
}
