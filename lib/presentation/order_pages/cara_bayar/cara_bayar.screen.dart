import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/cara_bayar/section/app_bar_section.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/assets/assets_images.dart';
import '../../../utils/assets/assets_svg.dart';
import '../../../utils/style/app_style.dart';
import 'controllers/cara_bayar.controller.dart';
import 'section/atm_section.dart';
import 'section/tabbar_section.dart';

class CaraBayarScreen extends GetView<CaraBayarController> {
  const CaraBayarScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarCaraBayar,
        body: ListView(
          children: [
            Gap(16.h),
            Container(
              padding: AppStyle.paddingSide16,
              child: GetBuilder<CaraBayarController>(builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: AppStyle.borderRadius8All,
                          border: AppStyle.borderAll),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: AppStyle.paddingAll16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bank Negara Indonesia',
                                    style: text12BlackSemiBold),
                                Image.asset(bni)
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: kDivider,
                            height: 0,
                          ),
                          SizedBox(
                            child: Padding(
                              padding: AppStyle.paddingAll16,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Virtual Account Number',
                                      style: text12BlackRegular),
                                  Gap(4.h),
                                  Row(
                                    children: [
                                      Text('88088123456778',
                                          style: text14BlackMedium),
                                      Gap(8.w),
                                      SvgPicture.asset(copy)
                                    ],
                                  ),
                                  Gap(8.h),
                                  Text('Virtual Account Name',
                                      style: text12BlackRegular),
                                  Gap(4.h),
                                  Text('XDT-TRATALION',
                                      style: text14BlackMedium),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),
                    TabBarSection(controller: controller),
                    SizedBox(
                        height: Get.height * 0.6,
                        child: TabBarView(
                            controller: controller.tabController,
                            children: const [
                              AtmSection(),
                              AtmSection(),
                              AtmSection()
                            ]))
                  ],
                );
              }),
            ),
          ],
        ));
  }
}
