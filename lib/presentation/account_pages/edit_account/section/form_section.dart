import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/account_pages/edit_account/controllers/edit_account.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_icon.dart';
import '../../../../components/picker/picker_images.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAccountController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.userFile == null
                  ? CachedNetworkImage(
                      imageUrl: controller.userData?.image ?? '',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 46.r,
                            backgroundColor: kPrimaryColor2,
                            backgroundImage: imageProvider,
                          ),
                      placeholder: (context, url) => SizedBox(
                            height: 72.r,
                            width: 72.r,
                            child: const Center(
                              child:
                                  CupertinoActivityIndicator(color: kSoftBlack),
                            ),
                          ),
                      errorWidget: (context, url, error) => CircleAvatar(
                            radius: 46.r,
                            backgroundColor: kPrimaryColor2,
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: kPrimaryColor,
                                size: 20.r,
                              ),
                            ),
                          ))
                  : CircleAvatar(
                      radius: 46.r,
                      backgroundColor: kPrimaryColor2,
                      backgroundImage: FileImage(controller.userFile!),
                    ),
              TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                        enterBottomSheetDuration: 200.milliseconds,
                        exitBottomSheetDuration: 200.milliseconds,
                        PickerImages.double(
                          onTapCamera: () => controller.getImageMenu(),
                          onTapGallery: () => controller.getImageGalery(),
                        ));
                  },
                  child: Text(
                    'Ubah Foto Profil',
                    style: text12NormalRegular,
                  ))
            ],
          ),
          Gap(16.h),
          AppForm(
            type: AppFormType.withLabel,
            controller: controller.namaController,
            label: 'Nama Lengkap',
            hintText: 'Isi nama lengkap disini',
            onChanged: (value) => controller.listenNameForm(value),
            isError: controller.isNameError,
            errorMessage: 'Masukkan nama yang valid',
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
                  Text(controller.genders[index], style: text12BlackRegular),
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
          AppForm(
            type: AppFormType.withLabel,
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            label: 'Nomor HP',
            hintText: 'Isi nomor hp disini',
            inputFormatters: controller.formaterNumber(),
            onChanged: (value) => controller.listenPhoneForm(value),
          ),
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
          AppFormIcon.resetPassword(
            type: AppFormIconType.withLabel,
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            isReadOnly: true,
            label: 'Password',
            hintText: 'Isi password disini',
            onChanged: (value) => controller.listenPasswordForm(value),
            onResetPassword: () => Get.toNamed(Routes.CHANGE_PASSWORD),
          ),
          Gap(16.h),
          GestureDetector(
            onTap: () => controller.confirmationDelete(),
            child: Row(
              children: [
                Container(
                  padding: AppStyle.paddingAll8,
                  decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    borderRadius: AppStyle.borderRadius6All,
                  ),
                  child: SvgPicture.asset(
                    delete,
                    colorFilter:
                        const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  ),
                ),
                Gap(8.w),
                Text('Hapus akun', style: text12PrimaryRegular)
              ],
            ),
          ),
          Gap(16.h),
        ],
      );
    });
  }
}
