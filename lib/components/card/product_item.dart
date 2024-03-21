import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/model_data/product.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/format_number.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';
import '../../utils/style/app_style.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.item, this.onTap});
  final Product item;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: AppStyle.borderRadius8All,
          boxShadow: [AppStyle.boxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: Uri.tryParse(item.thumbnail ?? '')?.isAbsolute == true
                  ? item.thumbnail ?? ''
                  : '',
              imageBuilder: (context, imageProvider) => Container(
                height: 92.h,
                decoration: BoxDecoration(
                  borderRadius: AppStyle.borderRadius8Top,
                  color: kSofterGrey,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 42.wr,
                      margin: AppStyle.paddingAll8,
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(26.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_rounded,
                              color: kWarningColor, size: 14.hr),
                          Gap(4.w),
                          Text(item.rating.toString(), style: text10HintRegular)
                        ],
                      ),
                    )),
              ),
              placeholder: (context, url) => SizedBox(
                height: 92.h,
                width: Get.width,
                child: const Center(
                  child: CupertinoActivityIndicator(color: kSoftBlack),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 92.h,
                decoration:
                    BoxDecoration(borderRadius: AppStyle.borderRadius8Top),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppStyle.borderRadius8Top,
                    color: kSofterGrey,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 8.w,
                          top: 8.w,
                          child: Container(
                            width: 42.wr,
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(26.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star_rounded,
                                    color: kWarningColor, size: 14.hr),
                                Gap(4.w),
                                Text(item.rating.toString(),
                                    style: text10HintRegular)
                              ],
                            ),
                          )),
                      Positioned.fill(
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: kPrimaryColor,
                            size: 20.r,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: AppStyle.paddingAll12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name ?? '', style: text12BlackRegular),
                    Gap(2.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                              "${item.promo != 0 ? item.promo : item.price}"
                                  .toIdrFormat,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: text14SuccessSemiBold),
                        ),
                        item.promo != 0
                            ? Expanded(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(item.price.toString().toIdrFormat,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: text10lineThroughRegular),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    Gap(4.h),
                    Text("${"${item.sold}".formatNumber} Terjual",
                        style: text10HintRegular),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
