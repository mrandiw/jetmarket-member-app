import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/account_pages/paylater_customer/controllers/paylater_customer.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class PaylaterSection extends StatelessWidget {
  const PaylaterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaylaterCustomerController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          Container(
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
                borderRadius: AppStyle.borderRadius8All,
                boxShadow: [AppStyle.boxShadow],
                gradient: const LinearGradient(
                    colors: [kPrimaryColor, Color(0xffE98F8B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sisa Limit', style: text12WhiteMedium),
                Gap(12.h),
                Text('${controller.detailPaylater?.limit}'.toIdrFormat,
                    style: text20WhiteSemiBold),
                Gap(12.h),
                Text(
                    'Total Kredit ${"${controller.detailPaylater?.total}".toIdrFormat}',
                    style: text12WhiteRegular),
              ],
            ),
          ),
          Gap(20.h),
          Container(
            padding: AppStyle.paddingAll12,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius8All,
              boxShadow: [AppStyle.boxShadow],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Jumlah yang perlu dibayar bulan ini',
                  style: text10HintRegular),
              Row(
                children: [
                  Text('${controller.detailPaylater?.bill?.amount}'.toIdrFormat,
                      style: text14BlackSemiBold),
                  const Spacer(),
                  AppButton.primarySmall(
                    text: 'Bayar',
                    onPressed: controller.detailPaylater?.bill?.amount != null
                        ? () => controller.toChoicePayment()
                        : null,
                  )
                ],
              ),
              Visibility(
                visible: controller.detailPaylater?.bill?.dueAt != null,
                child: Text(
                    'Batas pembayaran ${"${controller.detailPaylater?.bill?.dueAt}".convertToDateFormat}',
                    style: text10ErrorMedium),
              )
            ]),
          ),
          Gap(20.h),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.BILL_PAYLATER);
            },
            child: Container(
              height: 50.h,
              padding: AppStyle.paddingAll12,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: AppStyle.borderRadius8All,
                boxShadow: [AppStyle.boxShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tagihan Saya', style: text12BlackMedium),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: kBlack,
                    size: 18.r,
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
