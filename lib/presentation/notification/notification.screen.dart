import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/notification.controller.dart';
import 'section/app_bar_section.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        appBar: appBarNotification,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: List.generate(
              10,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      padding: AppStyle.paddingAll12,
                      decoration: BoxDecoration(
                          color: const Color(0xffF4F6FA),
                          borderRadius: AppStyle.borderRadius8All,
                          border: AppStyle.borderAll),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(solarNotification),
                              Gap(8.w),
                              Text('Pesanan', style: text11GreyRegular),
                              const Spacer(),
                              Text('Baru saja', style: text11GreyRegular)
                            ],
                          ),
                          Gap(8.h),
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pesanan Sedang Dalam Pengiriman',
                                      style: text12BlackRegular),
                                  Gap(2.w),
                                  Text('Sepatu Kulit Original Size 40',
                                      style: text11GreyRegular),
                                  Gap(2.w),
                                  Text('x1 Rp200.499',
                                      style: text11GreyRegular),
                                ],
                              )),
                              Container(
                                height: 50.r,
                                width: 50.r,
                                decoration: BoxDecoration(
                                    borderRadius: AppStyle.borderRadius8All,
                                    image: const DecorationImage(
                                        image: NetworkImage(
                                            'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'))),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
        ));
  }
}
