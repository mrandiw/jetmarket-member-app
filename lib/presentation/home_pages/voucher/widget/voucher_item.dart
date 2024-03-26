import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/badge/app_badge.dart';
import 'package:jetmarket/domain/core/model/model_data/vouchers.dart';
import 'package:jetmarket/presentation/home_pages/voucher/controllers/voucher.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_range.dart';
import 'package:jetmarket/utils/extension/percentage_formateer.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class VoucherItem extends StatelessWidget {
  const VoucherItem(
      {super.key,
      required this.index,
      required this.data,
      this.onTap,
      this.enable = true});

  final int index;
  final Vouchers data;
  final Function()? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(builder: (controller) {
      return GestureDetector(
        onTap: enable ? () => controller.selectVoucher(index) : null,
        child: Stack(
          children: [
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: kWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: AppStyle.borderRadius8All,
                  side: AppStyle.borderSide),
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              color: kSuccessColor2),
                          child: Text('Berlansung', style: text10SuccessMedium),
                        ),
                        Text(
                            "${data.createdAt} & ${data.expiredAt}"
                                .dateRangeConvert,
                            style: text10HintRegular)
                      ],
                    ),
                    Gap(12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
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
                              onChanged: (value) =>
                                  controller.selectVoucher(value!)),
                        ),
                        Gap(8.w),
                        Container(
                          height: 48.r,
                          width: 48.r,
                          decoration: BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(voucher),
                          ),
                        ),
                        Gap(8.w),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.name ?? '',
                                    style: text12BlackMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                Gap(6.h),
                                Visibility(
                                  visible:
                                      data.discount?.contains('%') ?? false,
                                  child: Text(
                                      "Cashback ${data.discount?.adjustPercentPosition}",
                                      style: text12BlackRegular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Visibility(
                                  visible:
                                      !(data.discount?.contains('%') ?? false),
                                  child: Text("Potongan ${data.discount}",
                                      style: text12BlackRegular,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ]),
                        )
                      ],
                    ),
                    Gap(12.h),
                    Container(
                      width: Get.width.wr,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                          color: kBorder,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Minimal Belanja ${"${data.min}".toIdrFormat}",
                              style: text12BlackRegular),
                          Gap(6.h),
                          Text("Maksimal Potongan ${"${data.max}".toIdrFormat}",
                              style: text12BlackRegular),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: enable == false,
                child: Container(
                  height: 180.h,
                  width: Get.width.wr,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kWhite.withOpacity(0.6)),
                ))
          ],
        ),
      );
      // return Card(
      //   elevation: 0,
      //   margin: EdgeInsets.zero,
      //   color: kWhite,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
      //   child: ListTile(
      //     onTap: onTap,
      //     contentPadding: AppStyle.paddingSide12,
      //     title: Text("${data.name}", style: text12BlackRegular),
      //     subtitle: Text(
      //       'Min. Belanja ${(data.min ?? 0).toString().toIdrFormat}',
      //       style: text12HintRegular,
      //     ),
      //     trailing: SizedBox(
      //       width: 26.w,
      //       child: RadioListTile(
      //           activeColor: kPrimaryColor,
      //           fillColor: MaterialStateProperty.all(
      //               controller.selectedVoucher == index
      //                   ? kPrimaryColor
      //                   : kDivider),
      //           value: index,
      //           selected: controller.selectedVoucher == index,
      //           groupValue: controller.selectedVoucher,
      //           onChanged: (value) => controller.selectVoucher(value!)),
      //     ),
      //   ),
      // );
    });
  }
}
