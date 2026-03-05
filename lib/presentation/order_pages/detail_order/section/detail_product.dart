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
    final products = controller.detailOrderCustomer?.products ?? [];
    return Padding(
        padding: AppStyle.paddingSide16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                controller.detailOrderCustomer?.sellerName != null &&
                        controller.detailOrderCustomer?.sellerName != ''
                    ? 'Produk dari ${controller.detailOrderCustomer?.sellerName}'
                    : 'Detail Produk',
                style: text14BlackMedium),
            Gap(12.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (context, index) => Gap(8.h),
              itemBuilder: (context, index) {
                final item = products[index];
                return Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All,
                      side: AppStyle.borderSide),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: item.image ?? '',
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
                    title: Text(item.name ?? '', style: text12BlackMedium),
                    subtitle: Text(
                        '${item.quantity} x ${item.price.toString().toIdrFormat}',
                        style: text11GreyRegular),
                  ),
                );
              },
            )
          ],
        ));
  }
}
