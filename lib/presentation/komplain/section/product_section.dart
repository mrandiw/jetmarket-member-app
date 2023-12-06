import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/komplain/controllers/komplain.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';

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
                  controller.products.length,
                  (index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 22.r,
                            width: 22.r,
                            child: Transform.scale(
                              scale: 1,
                              child: Checkbox(
                                  value: controller.addProduct
                                      .contains(controller.products[index]),
                                  activeColor: kPrimaryColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppStyle.borderRadius6All,
                                  ),
                                  onChanged: (value) =>
                                      controller.selectProduct(
                                          value!, controller.products[index])),
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
                                leading: ClipRRect(
                                  borderRadius: AppStyle.borderRadius8All,
                                  child: Image.network(
                                    'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    height: 40.r,
                                    width: 40.r,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(controller.products[index]['name'],
                                    style: text12BlackMedium),
                                subtitle: Text(
                                    controller.products[index]['price']
                                        .toString()
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
