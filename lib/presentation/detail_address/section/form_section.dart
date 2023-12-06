import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/detail_address/controllers/detail_address.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_text.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailAddressController>(
        init: DetailAddressController(),
        builder: (controller) {
          return Padding(
              padding: AppStyle.paddingAll16,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.addressController,
                      label: 'Alamat',
                      hintText: 'Masukkan alamat disini',
                      textArea: true,
                    ),
                    Gap(12.h),
                    Text('Label Alamat', style: text12BlackRegular),
                    Gap(8.h),
                    Container(
                      height: 44.h,
                      padding: AppStyle.paddingSide12,
                      decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius8All,
                          border: AppStyle.borderAll),
                      child: DropdownButton(
                        value: controller.selectedLabel,
                        underline: const SizedBox.shrink(),
                        isExpanded: true,
                        style: text12BlackRegular,
                        icon: SvgPicture.asset(
                          arrowDown,
                          colorFilter:
                              const ColorFilter.mode(kBlack, BlendMode.srcIn),
                        ),
                        items: controller.labels
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: text12BlackRegular,
                                )))
                            .toList(),
                        onChanged: (value) => controller.onChangeLabel(value!),
                      ),
                    ),
                    Gap(12.h),
                    AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.noteController,
                      label: 'Catatan Untuk Kurir (Opsional)',
                      hintText: 'Masukan warna rumah, patokan, dll',
                    ),
                    Gap(12.h),
                    AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.nameController,
                      label: 'Masukan Nama Penerima',
                      hintText: 'Masukan nama penerima disini',
                    ),
                    Gap(12.h),
                    AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.phoneController,
                      label: 'Nomor Hp',
                      hintText: 'Masukan Nomor Hp disini',
                    )
                  ]));
        });
  }
}
