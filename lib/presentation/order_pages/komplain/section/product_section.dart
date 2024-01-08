import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/komplain/controllers/komplain.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingVert12,
      child: GetBuilder<KomplainController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Barang mana yang kurang?', style: text14BlackMedium),
            Gap(10.h),
            Row(
              children: [
                SizedBox(
                  height: 22.r,
                  width: 22.r,
                  child: Transform.scale(
                    scale: 1,
                    child: Checkbox(
                        value: controller.selectAll,
                        activeColor: kPrimaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppStyle.borderRadius6All,
                        ),
                        side: const BorderSide(color: kSoftGrey, width: 1.2),
                        onChanged: (value) =>
                            controller.selectAllProduct(value!)),
                  ),
                ),
                Gap(8.w),
                Text('Pilih Semua Produk', style: text12BlackRegular),
              ],
            ),
            Gap(12.h),
            Column(
              children: List.generate(
                  controller.submitRefundModel?.productVariants?.length ?? 0,
                  (index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 22.r,
                            width: 22.r,
                            child: Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                  value: controller.addProduct.contains(
                                      controller.submitRefundModel
                                          ?.productVariants?[index]),
                                  activeColor: kPrimaryColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppStyle.borderRadius6All,
                                  ),
                                  side: const BorderSide(
                                      color: kSoftGrey, width: 1.2),
                                  onChanged: (value) =>
                                      controller.selectProduct(
                                          value!,
                                          controller.submitRefundModel
                                              ?.productVariants?[index])),
                            ),
                          ),
                          Gap(8.w),
                          Expanded(
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.only(bottom: 8.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: AppStyle.borderRadius8All,
                                  side: AppStyle.borderSide),
                              child: ListTile(
                                contentPadding: AppStyle.paddingSide8,
                                leading: CachedNetworkImage(
                                  imageUrl: controller.submitRefundModel
                                          ?.productVariants?[index].image ??
                                      '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 40.h,
                                    width: 40.h,
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
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                        color: kSofterGrey,
                                        borderRadius:
                                            AppStyle.borderRadius6All),
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
                                    controller.submitRefundModel
                                            ?.productVariants?[index].title ??
                                        '',
                                    style: text12BlackMedium),
                                subtitle: Text(
                                    "${controller.submitRefundModel?.productVariants?[index].price}"
                                        .toIdrFormat,
                                    style: text12HintRegular),
                              ),
                            ),
                          ),
                        ],
                      )),
            ),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dana bermasalah', style: text12HintForm),
                Text('${controller.totalPrice}'.toIdrFormat,
                    style: text12BlackRegular),
              ],
            )
          ],
        );
      }),
    );
  }
}
