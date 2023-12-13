import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingSide16,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: AppStyle.borderSide, top: AppStyle.borderSide)),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 26.r,
              backgroundColor: kPrimaryColor2,
            ),
            title: Text('Stationary’s', style: text14BlackMedium),
            subtitle: Row(
              children: [
                Icon(
                  Icons.circle,
                  color: kSuccessColor,
                  size: 8.r,
                ),
                Gap(4.w),
                Text('Online', style: text11SuccessRegular),
              ],
            ),
            trailing: SizedBox(
                width: 100.wr,
                child: AppButton.primary(
                  text: 'Lihat Toko',
                  onPressed: () => controller.toDetailStore(),
                )),
          ),
        ),
      );
    });
  }
}
