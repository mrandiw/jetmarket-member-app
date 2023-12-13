import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/add_address/controllers/add_address.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_icon.dart';
import '../../../../utils/assets/assets_svg.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFormIcon(
              controller: controller.searchController,
              icon: search,
              hintText: 'Tulis nama jalan/gedung/perumahan',
              onChanged: (value) {
                controller.searchLocation(value);
              },
            ),
            Gap(8.h),
            TextButton.icon(
                style: TextButton.styleFrom(
                  padding: AppStyle.paddingSide8,
                  foregroundColor: kSecondaryColor,
                ),
                onPressed: () => Get.toNamed(Routes.LOCATION,
                    arguments: {"with-latlong": false}),
                icon: SvgPicture.asset(location),
                label: Text('Gunakan lokasi saya saat ini',
                    style: text12PrimaryRegular))
          ],
        ),
      );
    });
  }
}
