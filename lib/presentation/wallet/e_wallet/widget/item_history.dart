import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/code_before_hash.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({super.key, required this.data, this.onTap});

  final BalanceHistoryModel data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    String code = data.refId?.getSubstringBeforeHash ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppStyle.paddingAll12,
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: AppStyle.borderRadius8All,
            border: AppStyle.borderAll),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(code == 'TOP' ? 'Top Up' : 'Withdraw',
                    style: text12BlackMedium),
                const Spacer(),
                amountBadge(code, data.amount ?? 0)
              ],
            ),
            Gap(4.h),
            Text(
              convertStatus(data.status ?? ''),
              style: convertColorText(data.status ?? ''),
            ),
            Gap(4.h),
            Text(data.description ?? '', style: text10HintRegular),
            Gap(8.h),
            Text(data.createdAt?.convertToDateFormat ?? '',
                style: text8GreyRegular),
          ],
        ),
      ),
    );
  }

  Widget amountBadge(String code, int amount) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: code == 'TOP' ? kSuccessColor2 : kErrorColor2),
      child: Row(
        children: [
          Text(code == 'TOP' ? '+' : '-',
              style: code == 'TOP' ? text10SuccessMedium : text10ErrorMedium),
          Gap(4.w),
          Text('${amount.abs()}'.toIdrFormat,
              style: code == 'TOP' ? text10SuccessMedium : text10ErrorMedium)
        ],
      ),
    );
  }

  String convertStatus(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return 'Pending';
      case 'WAITING_APPROVAL':
        return 'Menunggu Konfirmasi';
      case 'SUCCEEDED':
        return 'Berhasil';
      default:
        return 'Dibatalkan';
    }
  }

  TextStyle convertColorText(String status) {
    switch (status) {
      case 'WAITING_PAYMENT' || 'WAITING_APPROVAL':
        return text10WarningMedium;
      case 'CANCELLED':
        return text10ErrorMedium;
      default:
        return text10SuccessMedium;
    }
  }
}
