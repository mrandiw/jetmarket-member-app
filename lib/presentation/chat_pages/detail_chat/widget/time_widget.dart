import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key, required this.createdAtString});

  final String createdAtString;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          padding: AppStyle.paddingAll8,
          decoration: BoxDecoration(
            borderRadius: AppStyle.borderRadius8All,
            color: kWhite,
          ),
          child: Text(createdAtString, style: text12BlackRegular),
        ),
      ),
    );
  }
}
