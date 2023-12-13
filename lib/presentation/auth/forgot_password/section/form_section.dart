import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/forgot_password/controllers/forgot_password.controller.dart';
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
            child: GetBuilder<ForgotPasswordController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lupa Password', style: text20PrimarySemiBold),
                  Gap(4.h),
                  Text('Masukan email yang terhubung ke akun Anda.',
                      style: text14BlackRegular),
                  Gap(16.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email',
                    hintText: 'Isi email disini',
                    onChanged: (value) => controller.listenEmailForm(value),
                  ),
                  Gap(42.h),
                  Obx(() {
                    return AppButton.primary(
                      actionStatus: controller.actionStatus,
                      text: 'Reset Password',
                      onPressed: controller.isEmailValidated.value
                          ? () => controller.nextToSendOtp()
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
