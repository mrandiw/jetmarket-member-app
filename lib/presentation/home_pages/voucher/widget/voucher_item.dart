import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/vouchers.dart';
import 'package:jetmarket/presentation/home_pages/voucher/controllers/voucher.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/extension/format_price.dart';
import '../../../../utils/style/app_style.dart';

class VoucherItem extends StatelessWidget {
  const VoucherItem(
      {super.key, required this.index, required this.data, this.onTap});

  final int index;
  final Vouchers data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(builder: (controller) {
      return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: kWhite,
        shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
        child: ListTile(
          onTap: onTap,
          contentPadding: AppStyle.paddingSide12,
          title: Text("${data.name}", style: text12BlackRegular),
          subtitle: Text(
            'Min. Belanja ${formatPrice(data.min ?? 0)}',
            style: text12HintRegular,
          ),
          trailing: SizedBox(
            width: 26.w,
            child: RadioListTile(
                activeColor: kPrimaryColor,
                fillColor: MaterialStateProperty.all(
                    controller.selectedVoucher == index
                        ? kPrimaryColor
                        : kDivider),
                value: index,
                selected: controller.selectedVoucher == index,
                groupValue: controller.selectedVoucher,
                onChanged: (value) => controller.selectVoucher(value!)),
          ),
        ),
      );
    });
  }
}
