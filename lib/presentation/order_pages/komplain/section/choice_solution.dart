import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/komplain/controllers/komplain.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class ChoiceSolution extends StatelessWidget {
  const ChoiceSolution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(16.h),
        Text('Pilih Solusi', style: text14BlackMedium),
        GetBuilder<KomplainController>(builder: (controller) {
          return Column(
              children: List.generate(
                  2,
                  (index) => GestureDetector(
                        onTap: () {
                          controller.selectSolution(index);
                        },
                        child: Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8All,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 22.r,
                                height: 22.r,
                                child: Radio(
                                  activeColor: kPrimaryColor,
                                  fillColor: MaterialStateProperty.all(
                                    controller.seledtedSolutionIndex == index
                                        ? kPrimaryColor
                                        : kDivider,
                                  ),
                                  value: index,
                                  groupValue: controller.seledtedSolutionIndex,
                                  onChanged: (value) =>
                                      controller.selectSolution(value!),
                                ),
                              ),
                              Gap(12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    index == 0
                                        ? 'Kembalikan dana dan barang'
                                        : 'Kembalikan dana',
                                    style: text12BlackRegular,
                                  ),
                                  Gap(2.h),
                                  SizedBox(
                                    width: Get.width * 0.82,
                                    child: Text(
                                      index == 0
                                          ? 'Pembeli mengembalikan barang dan penjual mengembalikan dana'
                                          : 'Pembeli tidak perlu mengembalikan barang dan penjual mengembalikan dana',
                                      style: text11GreyRegular,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  // ListTile(
                  //       onTap: () {
                  //         controller.selectSolution(index);
                  //       },
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: AppStyle.borderRadius8All,
                  //       ),
                  //       contentPadding: EdgeInsets.zero,
                  //       minLeadingWidth: 22.w,
                  //       leading: Container(
                  //         alignment:
                  //             Alignment.topCenter, // Menempatkan widget di atas
                  //         width: 24.0, // Atur lebar sesuai kebutuhan Anda
                  //         height: 524.0, // Atur tinggi sesuai kebutuhan Anda
                  // child: RadioListTile(
                  //   activeColor: kPrimaryColor,
                  //   fillColor: MaterialStateProperty.all(
                  //     controller.seledtedSolutionIndex == index
                  //         ? kPrimaryColor
                  //         : kDivider,
                  //   ),
                  //   value: index,
                  //   selected: controller.seledtedSolutionIndex == index,
                  //   groupValue: controller.seledtedSolutionIndex,
                  //   onChanged: (value) =>
                  //       controller.selectSolution(value!),
                  // ),
                  //       ),
                  // title: Text(
                  //   index == 0
                  //       ? 'Kembalikan dana dan barang'
                  //       : 'Kembalikan dana',
                  //   style: text12BlackRegular,
                  // ),
                  //       subtitle: Text(
                  //         index == 0
                  //             ? 'Pembeli mengembalikan barang dan penjual mengembalikan dana'
                  //             : 'Pembeli tidak perlu mengembalikan barang dan penjual mengembalikan dana',
                  //         style: text11GreyRegular,
                  //       ),
                  //     )
                  ));
        })
      ],
    );
  }
}
