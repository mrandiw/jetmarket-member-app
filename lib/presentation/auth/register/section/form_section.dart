import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/register/controllers/register.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/navigation/routes.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const Gap(276),
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: AppStyle.borderRadius20Top),
            child: GetBuilder<RegisterController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Registrasi', style: text20PrimarySemiBold),
                  Gap(4.h),
                  Text('Silakan buat akun terlebih dahulu.',
                      style: text14BlackRegular),
                  Gap(16.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.namaController,
                    label: 'Nama Lengkap',
                    hintText: 'Isi nama lengkap disini',
                    onChanged: (value) => controller.listenNameForm(value),
                  ),
                  Gap(12.h),
                  Text('Jenis Kelamin', style: text12BlackRegular),
                  Gap(6.h),
                  Row(
                    children: List.generate(
                      controller.genders.length,
                      (index) => SizedBox(
                        height: 42.h,
                        child: Row(children: [
                          GestureDetector(
                            onTap: () => controller.selectGender(index),
                            child: SizedBox(
                              height: 16.r,
                              width: 26.r,
                              child: Radio(
                                value: index,
                                groupValue: controller.selectedGender,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  controller.selectGender(value ?? 0);
                                },
                              ),
                            ),
                          ),
                          Gap(4.w),
                          Text(controller.genders[index],
                              style: text12BlackRegular),
                          Gap(16.w),
                        ]),
                      ),
                    ),
                  ),
                  Gap(12.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.phoneController,
                    label: 'Nomor HP',
                    hintText: 'Isi nomor hp disini',
                    onChanged: (value) => controller.listenPhoneForm(value),
                  ),
                  Gap(12.h),
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
                  Gap(12.h),
                  Text('Biaya Regristrasi', style: text12BlackRegular),
                  Gap(6.h),
                  Obx(() {
                    return Row(
                      children: [
                        Text(
                            controller.isKodeReveralValidated.value
                                ? '10000'.toIdrFormat
                                : '25000'.toIdrFormat,
                            style: text12PrimaryRegular),
                        Gap(12.w),
                        Visibility(
                          visible: controller.isKodeReveralValidated.value,
                          child: Text('250000'.toIdrFormat,
                              style: text10lineThroughRegular),
                        ),
                      ],
                    );
                  }),
                  Gap(16.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.referralController,
                    label: 'Kode Referal',
                    hintText: 'Isi kode referal disini',
                    onChanged: (value) =>
                        controller.listenKodeReveralForm(value),
                  ),
                  Gap(12.h),
                  Obx(() {
                    return Visibility(
                      visible: controller.isKodeReveralValidated.value,
                      child: Container(
                        padding: AppStyle.paddingAll12,
                        decoration: BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius: AppStyle.borderRadius8All),
                        child: Text(
                            'Yeay, kode referral terpasang! Silakan melakukan pembayaran sebesar Rp10.000',
                            style: text12BlackRegular),
                      ),
                    );
                  }),
                  Gap(34.h),
                  Obx(() {
                    return AppButton.primary(
                      actionStatus: controller.actionStatus,
                      text: controller.selectedPaymentMethode.value != ""
                          ? 'Bayar'
                          : 'Lanjut',
                      onPressed: controller.isNameValidated.value &&
                              controller.isPhoneValidated.value &&
                              controller.isEmailValidated.value &&
                              controller.isPasswordValidated.value
                          ? controller.selectedPaymentMethode.value == ""
                              ? () => controller.register()
                              : () => controller.payAndRegister()
                          : null,
                    );
                  }),
                  Gap(34.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sudah punya akun?',
                            style: text12BlackRegular,
                          ),
                          TextSpan(
                            text: ' Login',
                            style: text12NormalAccentRegular,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.LOGIN);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(34.h),
                ],
              );
            }),
          ),
        ],
      ),
    ));
  }
}
