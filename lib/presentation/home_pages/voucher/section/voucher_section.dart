import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/voucher.controller.dart';

class VoucherSection extends StatelessWidget {
  const VoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(builder: (controller) {
      return ListView.builder(
          itemCount: controller.vouchers.length,
          padding: AppStyle.paddingAll16,
          itemBuilder: (_, index) {
            return Padding(
              padding: AppStyle.paddingBottom8,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadius8All,
                    side: AppStyle.borderSide),
                child: ListTile(
                  onTap: () => controller.selectVoucher(index),
                  contentPadding: AppStyle.paddingSide12,
                  title: Text("${controller.vouchers[index]['title']}",
                      style: text12BlackRegular),
                  subtitle: Text(
                    '${controller.vouchers[index]['subtitle']}',
                    style: text12HintRegular,
                  ),
                  trailing: SizedBox(
                    width: 26.w,
                    child: RadioListTile(
                        activeColor: kPrimaryColor,
                        value: index,
                        selected: controller.selectedVoucher == index,
                        groupValue: controller.selectedVoucher,
                        onChanged: (value) => controller.selectVoucher(value!)),
                  ),
                ),
              ),
            );
          });
    });
  }
}
