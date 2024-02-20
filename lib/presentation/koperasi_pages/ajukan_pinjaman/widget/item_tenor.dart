import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/ajukan_pinjaman/controllers/ajukan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ItemTenor extends StatelessWidget {
  const ItemTenor({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AjukanPinjamanController>(builder: (controller) {
      return AppBottomSheet.witoutFooter(
          title: 'Pilih Tenor',
          child: ListView.separated(
              padding: EdgeInsets.only(top: 12.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => controller.selectTenor(controller.tenor[index]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${controller.tenor[index]} Bulan (${(controller.nominal / controller.tenor[index]).toStringAsFixed(0).toIdrFormat} / Bulan)",
                        style: text12BlackRegular,
                      ),
                      Container(
                          height: 14.r,
                          width: 14.r,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kWhite,
                              border: Border.all(
                                  color: controller.selectedTenor ==
                                          controller.tenor[index]
                                      ? kSecondaryColor
                                      : kDivider,
                                  width: controller.selectedTenor ==
                                          controller.tenor[index]
                                      ? 3
                                      : 1.4))),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, i) => Padding(
                  padding: AppStyle.paddingVert16,
                  child: Divider(
                    color: kDivider,
                    height: 0,
                  )),
              itemCount: controller.tenor.length));
    });
  }
}
