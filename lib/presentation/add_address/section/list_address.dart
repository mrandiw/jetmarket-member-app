import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/add_address/controllers/add_address.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ListAddress extends StatelessWidget {
  const ListAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(builder: (controller) {
      return controller.resultLocation == ResultLocation.success
          ? Column(
              children: List.generate(
                  controller.locations.length,
                  (index) => Padding(
                        padding: AppStyle.paddingSide16,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: AppStyle.borderRadius8All,
                              side: AppStyle.borderSide),
                          child: ListTile(
                            onTap: () => controller
                                .toLocationMap(controller.locations[index]),
                            leading: SvgPicture.asset(pinMapLine),
                            minLeadingWidth: 8.w,
                            minVerticalPadding: 12.h,
                            visualDensity: VisualDensity.compact,
                            title: Text(
                                controller.locations[index].placeName ?? '',
                                style: text12BlackSemiBold),
                            subtitle: Text(
                                controller.locations[index].address ?? '',
                                style: text12BlackRegular),
                          ),
                        ),
                      )))
          : controller.resultLocation == ResultLocation.loading
              ? SizedBox(
                  height: 300.h,
                  width: Get.width,
                  child: const Center(
                      child: CupertinoActivityIndicator(
                    color: kPrimaryColor,
                  )))
              : const SizedBox.shrink();
    });
  }
}
