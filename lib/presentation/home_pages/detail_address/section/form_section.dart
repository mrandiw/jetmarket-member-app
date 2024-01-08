import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_address/controllers/detail_address.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailAddressController>(builder: (controller) {
      return Padding(
          padding: AppStyle.paddingAll16,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppForm(
              type: AppFormType.withLabel,
              controller: controller.addressController,
              label: 'Alamat',
              hintText: 'Masukkan alamat disini',
              textArea: true,
            ),
            Gap(12.h),
            AppForm(
              type: AppFormType.withLabel,
              controller: controller.labelController,
              label: 'Label Alamat',
              hintText: 'Masukan label alamat',
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
                keyboardType: TextInputType.number,
                inputFormatters: controller.formaterNumber(),
                onChanged: (value) {
                  controller.listenPhoneForm(value);
                }),
            Gap(12.h),
            AppForm(
                type: AppFormType.withLabel,
                controller: controller.kodePosController,
                label: 'Kode Pos',
                hintText: 'Masukan kode pos disini',
                keyboardType: TextInputType.number)
          ]));
    });
  }
}
