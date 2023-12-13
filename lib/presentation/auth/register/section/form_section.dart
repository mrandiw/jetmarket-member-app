import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/auth/register/controllers/register.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/button/back_button.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/assets/assets_svg.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppStyle.paddingAll16,
            child: AppBackButton.circle(),
          ),
          Gap(220.hr),
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
                  Text('Tanggal Lahir', style: text12BlackRegular),
                  Gap(8.h),
                  GestureDetector(
                    onTap: () => controller.openCalendarView(),
                    child: Container(
                      height: 42.h,
                      padding: AppStyle.paddingAll12,
                      decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius8All,
                          color: kWhite,
                          border: AppStyle.borderAll),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              controller.selectedDatePicker != ""
                                  ? controller.selectedDatePicker
                                  : 'Pilih Tanggal Lahir',
                              style: controller.selectedDatePicker != ""
                                  ? text12BlackRegular
                                  : text12HintRegular),
                          SvgPicture.asset(calendar)
                        ],
                      ),
                    ),
                  ),
                  Gap(12.h),
                  GetBuilder<RegisterController>(builder: (controller) {
                    return AppForm(
                      type: AppFormType.withLabel,
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      label: 'Nomor HP',
                      hintText: 'Isi nomor hp disini',
                      inputFormatters: controller.formaterNumber(),
                      onChanged: (value) => controller.listenPhoneForm(value),
                    );
                  }),
                  Gap(12.h),
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email',
                    hintText: 'Isi email disini',
                    onChanged: (value) => controller.listenEmailForm(value),
                  ),
                  Gap(12.h),
                  AppFormIcon.password(
                    type: AppFormIconType.withLabel,
                    controller: controller.passwordController,
                    keyboardType: TextInputType.visiblePassword,
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
                          child: Text('25000'.toIdrFormat,
                              style: text10lineThroughRegular),
                        ),
                      ],
                    );
                  }),
                  Gap(16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 9,
                        child: AppForm(
                          type: AppFormType.withLabel,
                          controller: controller.referralController,
                          // focusNode: controller.focusNodeReferral,
                          label: 'Kode Referal',
                          hintText: 'Isi kode referal disini',
                        ),
                      ),
                      Gap(8.wr),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          child: AppButton.primary(
                            text: 'Claim',
                            onPressed: () => controller.checkReferralCode(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Gap(12.h),
                  Obx(() {
                    return Visibility(
                      visible: controller.isKodeReveralValidated.value ||
                          controller.isKodeReveralError.value,
                      child: Container(
                        padding: AppStyle.paddingAll12,
                        decoration: BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius: AppStyle.borderRadius8All),
                        child: Text(controller.referralMessage.value,
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
                              controller.isPasswordValidated.value &&
                              controller.selectedDatePicker != ""
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
