import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/format_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import 'controllers/order_list_transaction.controller.dart';
import 'section/app_bar_section.dart';

class OrderListTransactionScreen
    extends GetView<OrderListTransactionController> {
  const OrderListTransactionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.bacAction();
        return true;
      },
      child: Scaffold(
          appBar: appBarDetailOrder,
          body:
              GetBuilder<OrderListTransactionController>(builder: (controller) {
            return ListView.separated(
              itemCount: controller.products.length,
              padding: AppStyle.paddingAll16,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => controller
                      .toDetailOrder(controller.products[index].id ?? 0),
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: AppStyle.borderRadius8All,
                        side: AppStyle.borderSide),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: AppStyle.paddingAll12,
                            child: Text(
                                controller.products[index].status?.formatText ??
                                    '',
                                style: text12WarningMedium)),
                        Divider(height: 0, thickness: 1, color: kBorder),
                        Padding(
                          padding: AppStyle.paddingAll12,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    controller.products[index].image ?? '',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 50.h,
                                  width: 50.h,
                                  decoration: BoxDecoration(
                                    color: kSofterGrey,
                                    borderRadius: AppStyle.borderRadius8All,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    const CupertinoActivityIndicator(
                                        color: kSoftBlack),
                                errorWidget: (context, url, error) => Container(
                                  height: 50.h,
                                  width: 50.h,
                                  decoration: BoxDecoration(
                                      color: kSofterGrey,
                                      borderRadius: AppStyle.borderRadius6All),
                                  child: Center(
                                    child: Icon(
                                      Icons.error,
                                      color: kPrimaryColor,
                                      size: 18.r,
                                    ),
                                  ),
                                ),
                              ),
                              Gap(6.h),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.products[index].name ?? '',
                                        style: text12BlackSemiBold),
                                    Gap(6.h),
                                    Row(
                                      children: [
                                        Text(
                                            '${controller.products[index].qty}x',
                                            style: text12HintRegular),
                                        Gap(4.w),
                                        Text(
                                            '${controller.products[index].price}'
                                                .toIdrFormat,
                                            style: text12HintRegular),
                                      ],
                                    ),
                                  ])
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.products[index].totalItem! > 1,
                          child: Center(
                              child: Text(
                            'Lihat ${controller.products[index].totalItem! - 1} produk lainnya',
                            style: text12HintRegular,
                          )),
                        ),
                        Gap(12.h),
                        Divider(height: 0, thickness: 1, color: kBorder),
                        Padding(
                          padding: AppStyle.paddingAll12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total bayar', style: text12BlackRegular),
                              Text(
                                  '${controller.products[index].totalAmount}'
                                      .toIdrFormat,
                                  style: text12PrimaryMedium)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, i) => Gap(8.h),
            );
          })),
    );
  }
}
