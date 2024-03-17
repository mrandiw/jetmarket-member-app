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
                Text(convertType(code), style: text12BlackMedium),
                const Spacer(),
                amountBadge(code, data.amount ?? 0)
              ],
            ),
            Gap(4.h),
            // Text(
            //   data.createdAt?.convertToCustomFormat ?? '',
            //   style: text10HintRegular,
            // ),
            // Gap(4.h),
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
    bool isPlus = code == 'TOP' || code == 'REF';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: isPlus ? kSuccessColor2 : kErrorColor2),
      child: Row(
        children: [
          Text(isPlus ? '+' : '-',
              style: isPlus ? text10SuccessMedium : text10ErrorMedium),
          Gap(4.w),
          Text('${amount.abs()}'.toIdrFormat,
              style: isPlus ? text10SuccessMedium : text10ErrorMedium)
        ],
      ),
    );
  }

  String convertType(String status) {
    switch (status) {
      case 'TOP':
        return 'Top Up';
      case 'WID':
        return 'Withdraw';
      case 'REF':
        return 'Referral';
      case 'ORD':
        return 'Order';
      case 'BIL':
        return 'Tagihan';
      case 'LON':
        return 'Pinjaman';
      case 'SAV':
        return 'Tabungan';
      default:
        return '-';
    }
  }

  String convertStatus(String status) {
    switch (status) {
      case 'WAITING_PAYMENT':
        return 'Menunggu Pembayaran';
      case 'WAITING_APPROVAL':
        return 'Menunggu Konfirmasi';
      case 'SUCCEEDED':
        return 'Berhasil';
      case 'PENDING':
        return 'Sedang Diproses';
      case 'CANCELLED':
        return 'Dibatalkan';
      case 'REJECTED':
        return 'Ditolak';
      case '':
        return '-';
      default:
        return 'Gagal';
    }
  }

  TextStyle convertColorText(String status) {
    switch (status) {
      case 'WAITING_PAYMENT' || 'WAITING_APPROVAL' || 'PENDING':
        return text10WarningMedium;
      case 'CANCELLED' || 'FAILED' || 'REJECTED':
        return text10ErrorMedium;
      case '':
        return text10HintRegular;
      default:
        return text10SuccessMedium;
    }
  }
}
