import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/cart/controllers/cart.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class SelectAllProduct extends StatelessWidget {
  const SelectAllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: AppStyle.paddingSide16,
      child: GetBuilder<CartController>(builder: (controller) {
        return Row(
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
                    side: const BorderSide(color: kSoftGrey, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius6All,
                    ),
                    onChanged: (value) => controller.selectAllProduct(value!)),
              ),
            ),
            Gap(8.w),
            Text('Pilih Semua Produk', style: text12BlackRegular),
            const Spacer(),
            TextButton(
                style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                onPressed: () => controller.deleteAllProduct(),
                child: Text(
                  'Hapus',
                  style: text12PrimaryRegular,
                ))
          ],
        );
      }),
    ));
  }
}
