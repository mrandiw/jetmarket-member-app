import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/login/controllers/login.controller.dart';
import 'package:jetmarket/presentation/auth/reset_password/controllers/reset_password.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/button/app_button.dart';
import '../../../../infrastructure/navigation/routes.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const Gap(270),
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: AppStyle.borderRadius20Top),
            child: GetBuilder<ResetPasswordController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Buat Password Baru', style: text20PrimarySemiBold),
                  Gap(4.h),
                  Text('Silakan buat password baru untuk akunmu',
                      style: text14BlackRegular),
                  Gap(16.h),
                  AppFormIcon.password(
                    type: AppFormIconType.withLabel,
                    controller: controller.passwordController,
                    label: 'Password',
                    hintText: 'Isi password disini',
                    onChanged: (value) => controller.listenPasswordForm(value),
                  ),
                  Gap(12.h),
                  AppFormIcon.password(
                    type: AppFormIconType.withLabel,
                    controller: controller.konfirmasiPasswordController,
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
                      onPressed:
                          controller.isKonfirmasiPasswordValidated.value &&
                                  controller.isPasswordValidated.value
                              ? () => controller.resetPassword()
                              : null,
                    );
                  }),
                ],
              );
            }),
          ),
        ],
      ),
    ));
  }
}
