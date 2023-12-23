import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/controllers/edit_address.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_icon.dart';
import '../../../../utils/assets/assets_svg.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAddressController>(builder: (controller) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppFormIcon(
                controller: controller.searchController,
                icon: search,
                hintText: 'Cari alamat',
                onChanged: (value) => controller.onSearch(value),
              ),
              Gap(8.h),
              Row(
                children: [
                  Text('Semua Alamat', style: text14BlackMedium),
                  const Spacer(),
                  AppButton.secondaryIcon(
                    onPressed: () => Get.toNamed(Routes.ADD_ADDRESS),
                    icon: plus,
                    text: 'Alamat',
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
