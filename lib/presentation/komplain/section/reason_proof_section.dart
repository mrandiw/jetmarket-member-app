import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/komplain/controllers/komplain.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_text.dart';

class ReasonProofSection extends StatelessWidget {
  const ReasonProofSection({super.key, required this.controller});

  final KomplainController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Alasan barang tidak lengkap', style: text14BlackMedium),
          Gap(10.h),
          AppForm(textArea: true, controller: controller.reasonController),
          Gap(8.h),
          Text(
            'Min. 20 karakter',
            style: text11GreyRegular,
          ),
          Gap(16.h),
          Text('Bukti Foto/Video', style: text14BlackMedium),
          Gap(12.h),
          Visibility(
              visible: controller.dataProof.isNotEmpty,
              child: Padding(
                  padding: AppStyle.paddingBottom12,
                  child: Column(
                      children:
                          List.generate(controller.dataProof.length, (index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.only(bottom: 8.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: AppStyle.borderRadius8All,
                                side: AppStyle.borderSide),
                            child: ListTile(
                              contentPadding: AppStyle.paddingSide8,
                              leading: Container(
                                height: 40.r,
                                width: 40.r,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                        image: FileImage(
                                            controller.proofImagesView[index]),
                                        fit: BoxFit.cover)),
                              ),
                              title:
                                  Text('Deskripsi', style: text12BlackMedium),
                              subtitle: SizedBox(
                                height: 20.h,
                                width: Get.width * 0.5,
                                child: TextFormField(
                                  controller:
                                      controller.descriptionController[index],
                                  style: text10BlackRegular,
                                  cursorColor: kPrimaryColor,
                                  cursorWidth: 1.2,
                                  cursorHeight: 10.h,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      hintStyle: text10HintRegular,
                                      hintText: "Tulis deskripsi disini",
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(16.w),
                        GestureDetector(
                          onTap: () => controller.deleteProof(index),
                          child: SvgPicture.asset(delete),
                        ),
                        Gap(8.w),
                      ],
                    );
                  })))),
          GestureDetector(
            onTap: () => controller.pickImagePfoof(),
            child: Container(
              padding: AppStyle.paddingAll12,
              decoration: BoxDecoration(
                  color: kPrimaryColor2,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle_outline_rounded,
                    color: kPrimaryColor,
                  ),
                  Gap(8.w),
                  Text(
                    'Upload Bukti',
                    style: text14PrimarySemiBold,
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
