import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/change_password/controllers/change_password.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/button/app_button.dart';
import '../../../components/form/app_form_icon.dart';
import '../../../infrastructure/theme/app_text.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          Text('Ubah password', style: text20PrimarySemiBold),
          Gap(4.h),
          Text('Silakan buat password baru untuk akunmu',
              style: text14BlackRegular),
          Gap(16.h),
          AppFormIcon.password(
            type: AppFormIconType.withLabel,
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            label: 'Password',
            hintText: 'Isi password disini',
            onChanged: (value) => controller.listenPasswordForm(value),
          ),
          Gap(12.h),
          AppFormIcon.password(
            type: AppFormIconType.withLabel,
            controller: controller.konfirmasiPasswordController,
            keyboardType: TextInputType.visiblePassword,
            label: 'Konfirmasi Password',
            hintText: 'Isi Konfirmasi Password disini',
            onChanged: (value) =>
                controller.listenKonfirmasiPasswordForm(value),
          ),
          Gap(58.h),
          Obx(() {
            return AppButton.primary(
              actionStatus: controller.actionStatus,
              text: 'Simpan',
              onPressed: controller.isKonfirmasiPasswordValidated.value &&
                      controller.isPasswordValidated.value
                  ? () => controller.resetPassword()
                  : null,
            );
          }),
        ],
      );
    });
  }
}
