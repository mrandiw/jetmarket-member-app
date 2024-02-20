import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../domain/core/model/model_data/refferal_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({
    super.key,
    required this.data,
  });

  final RefferalModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadius8All,
      ),
      shadowColor: const Color(0xffE0E0EC).withOpacity(0.2),
      elevation: 4,
      child: ListTile(
          tileColor: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
          title: Text(
            data.downlineName ?? '',
            style: text12BlackMedium,
          ),
          subtitle: Text(
            "${data.amount}".toIdrFormat,
            style: text12HintRegular,
          )),
    );
  }
}
