import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key, required this.controller});

  final DetailOrderController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingSide16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Produk', style: text14BlackMedium),
            Gap(12.h),
            Column(
                children: List.generate(
                    controller.detailOrderCustomer?.products?.length ?? 0,
                    (index) {
              return Padding(
                padding: AppStyle.paddingBottom8,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All,
                      side: AppStyle.borderSide),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: controller
                              .detailOrderCustomer?.products?[index].image ??
                          '',
                      imageBuilder: (context, imageProvider) => Container(
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
                          const CupertinoActivityIndicator(color: kSoftBlack),
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
                    title: Text(
                        controller.detailOrderCustomer?.products?[index].name ??
                            '',
                        style: text12BlackMedium),
                    subtitle: Text(
                        '${controller.detailOrderCustomer?.products?[index].quantity} x ${controller.detailOrderCustomer?.products?[index].price.toString().toIdrFormat}',
                        style: text11GreyRegular),
                  ),
                ),
              );
            }))
          ],
        ));
  }
}
