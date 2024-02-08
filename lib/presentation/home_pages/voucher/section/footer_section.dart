import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/voucher/controllers/voucher.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoucherController>(builder: (controller) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: AppStyle.paddingAll16,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius20Top,
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffE3BEBD).withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -6))
                  ]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 9,
                        child: AppForm(
                          type: AppFormType.withLabel,
                          controller: controller.searchVoucherController,
                          label: 'Kode Voucher',
                          hintText: 'Isi kode voucher disini',
                        ),
                      ),
                      Gap(8.wr),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          child: AppButton.primary(
                            actionStatus: controller.actionClaimStatus,
                            text: 'Claim',
                            onPressed: () => controller.checkVoucherCode(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      visible: controller.voucherMessage != null,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Container(
                          width: Get.width.wr,
                          padding: AppStyle.paddingAll12,
                          decoration: BoxDecoration(
                              borderRadius: AppStyle.borderRadius8All,
                              color: kPrimaryColor2),
                          child: Text(controller.voucherMessage ?? '',
                              style: text12BlackRegular),
                        ),
                      )),
                  Gap(16.hr),
                  AppButton.primary(
                    text: 'Ok',
                    onPressed: () => controller.updateSelectedVoucer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
