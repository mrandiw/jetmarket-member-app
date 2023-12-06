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
            child: GetBuilder<LoginController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selamat Datang', style: text20PrimarySemiBold),
                  Gap(4.h),
                  Text('Silakan Login ke akun Anda.',
                      style: text14BlackRegular),
                  Gap(16.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.emailController,
                    label: 'Email',
                    hintText: 'Isi email disini',
                    onChanged: (value) => controller.listenEmailForm(value),
                  ),
                  Gap(12.h),
                  AppFormIcon.password(
                    type: AppFormIconType.withLabel,
                    controller: controller.passwordController,
                    label: 'Password',
                    hintText: 'Isi password disini',
                    onChanged: (value) => controller.listenPasswordForm(value),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: kNormalColor),
                        onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                        child: Text('Lupa Password?',
                            style: text12NormalAccentRegular)),
                  ),
                  Gap(58.h),
                  Obx(() {
                    return AppButton.primary(
                      actionStatus: controller.actionStatus,
                      text: 'Login',
                      onPressed: controller.isEmailValidated.value &&
                              controller.isPasswordValidated.value
                          ? () => controller.login()
                          : null,
                    );
                  }),
                  Gap(66.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Belum punya akun?',
                            style: text12BlackRegular,
                          ),
                          TextSpan(
                            text: ' Daftar',
                            style: text12NormalAccentRegular,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.REGISTER);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(66.h),
                ],
              );
            }),
          ),
        ],
      ),
    ));
  }
}
