import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: GetBuilder<EWalletController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('All History', style: text14BlackMedium),
            Gap(12.hr),
            Column(
                children: List.generate(
                    controller.histories.length,
                    (index) => Padding(
                        padding: AppStyle.paddingBottom12,
                        child: GestureDetector(
                          onTap:
                              controller.histories[index]['type'] != 'waiting'
                                  ? null
                                  : () => Get.toNamed(Routes.WITHDRAW_STATUS),
                          child: Container(
                              padding: AppStyle.paddingAll12,
                              decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: AppStyle.borderRadius8All,
                                  border: AppStyle.borderAll),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(index == 0
                                      ? wdSuccess
                                      : index == 1
                                          ? wdReject
                                          : index == 2
                                              ? wdWaiting
                                              : wdCancel),
                                  Gap(12.wr),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              controller.histories[index]
                                                  ['title'],
                                              style: text12BlackMedium),
                                          Text('20/11/2023',
                                              style: text8GreyRegular)
                                        ],
                                      ),
                                      Gap(4.hr),
                                      Text(
                                        controller.histories[index]['subtitle'],
                                        style: text11GreyRegular,
                                      ),
                                      Visibility(
                                        visible: controller.histories[index]
                                                    ['type'] ==
                                                'success' ||
                                            controller.histories[index]
                                                    ['type'] ==
                                                'reject',
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 6.h),
                                          child: GestureDetector(
                                              onTap: () => Get.toNamed(
                                                  Routes.DETAIL_WITHDRAW),
                                              child: Text('Lihat Detail',
                                                  style: text11PrimaryRegular)),
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              )),
                        ))))
          ],
        );
      }),
    );
  }
}
