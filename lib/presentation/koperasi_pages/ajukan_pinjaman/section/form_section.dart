import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/form/app_form_nominal.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/ajukan_pinjaman/controllers/ajukan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/formatter/nominal_formatter.dart';
import '../../../../components/picker/picker_images.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AjukanPinjamanController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppForm(
                controller: controller.nameController,
                label: 'Nama Lengkap',
                hintText: 'Isi nama lengkap disini...',
                type: AppFormType.withLabel,
                onChanged: controller.listenNameForm,
              ),
              Gap(8.hr),
              AppForm(
                  controller: controller.addressController,
                  label: 'Alamat',
                  hintText: 'Isi alamat disini...',
                  type: AppFormType.withLabel,
                  textArea: true,
                  onChanged: controller.listenAddressForm),
              Gap(8.hr),
              AppForm(
                  controller: controller.ktpController,
                  label: 'No. KTP',
                  hintText: 'Isi nomor ktp disini...',
                  type: AppFormType.withLabel,
                  keyboardType: TextInputType.number,
                  onChanged: controller.listenKtpForm),
              Gap(8.hr),
              Text('Selfie', style: text12BlackRegular),
              Gap(8.hr),
              controller.userFile != null
                  ? CachedNetworkImage(
                      imageUrl: controller.imageUrl ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                            height: 55.r,
                            width: 55.r,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius8All,
                                color: kBorder,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                      placeholder: (context, url) => SizedBox(
                            height: 55.r,
                            width: 55.r,
                            child: const Center(
                              child:
                                  CupertinoActivityIndicator(color: kSoftBlack),
                            ),
                          ),
                      errorWidget: (context, url, error) => Container(
                            height: 55.r,
                            width: 55.r,
                            decoration: BoxDecoration(
                              borderRadius: AppStyle.borderRadius8All,
                              color: kBorder,
                            ),
                          ))
                  : GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                            enterBottomSheetDuration: 200.milliseconds,
                            exitBottomSheetDuration: 200.milliseconds,
                            PickerImages.double(
                              onTapCamera: () => controller.getImageMenu(),
                              onTapGallery: () => controller.getImageGalery(),
                            ));
                      },
                      child: Container(
                        height: 55.r,
                        width: 55.r,
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8All,
                            color: kBorder),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_rounded,
                              color: kSecondaryColor,
                              size: 26.r,
                            ),
                            Gap(2.h),
                            Text(
                              'Tambah',
                              style: text8GreyRegular.copyWith(
                                  fontSize: 8.6,
                                  color: const Color(0xff808080)),
                            )
                          ],
                        ),
                      ),
                    ),
              Gap(8.hr),
              Text('Rekening', style: text12BlackRegular),
              Gap(8.hr),
              Container(
                height: 44.r,
                width: Get.width.wr,
                decoration: BoxDecoration(
                    borderRadius: AppStyle.borderRadius8All,
                    border: Border.all(color: kBorder),
                    color: kWhite),
                child: DropdownButton(
                    value: controller.selectedRekening,
                    hint: Text('Pilih Rekening', style: text12HintForm),
                    style: text12BlackRegular,
                    isExpanded: true,
                    padding: AppStyle.paddingSide12,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: kBlack,
                    ),
                    underline: const SizedBox.shrink(),
                    items: controller.listRekening
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: text12BlackRegular)))
                        .toList(),
                    onChanged: (value) => controller.selectRekening(value!)),
              ),
              Gap(8.hr),
              AppForm(
                  controller: controller.noRekController,
                  label: 'No. Rekening',
                  hintText: 'Isi nomor rekening disini...',
                  type: AppFormType.withLabel,
                  keyboardType: TextInputType.number,
                  onChanged: controller.listenNoRekForm),
              Gap(8.hr),
              AppForm(
                  controller: controller.nameRekController,
                  label: 'Nama Pemilik Rekening',
                  hintText: 'Isi nama pemilik rekening disini...',
                  type: AppFormType.withLabel,
                  onChanged: controller.listenNameRekForm),
              Gap(8.hr),
              Text('*Pastikan nama pemilik rekening sama dengan nama pengguna',
                  style: text12HintRegular),
              Gap(12.hr),
              Text('Nominal Pinjaman', style: text12BlackRegular),
              Gap(8.hr),
              AppFormNominal(
                  controller: controller.nominalRekController,
                  inputFormatters: [NominalFormatter()],
                  onChanged: controller.listenNominalRekForm),
              Gap(12.hr),
              Text('Tenor', style: text12BlackRegular),
              Gap(8.hr),
              GestureDetector(
                onTap: controller.nominal > 0
                    ? () => controller.openSelectedTenor()
                    : null,
                child: Container(
                  height: 44.r,
                  width: Get.width.wr,
                  padding: AppStyle.paddingAll12,
                  decoration: BoxDecoration(
                      borderRadius: AppStyle.borderRadius8All,
                      border: Border.all(color: kBorder),
                      color: controller.nominal > 0 ? kWhite : kSofterGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.getTenor,
                        style: text12BlackRegular,
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: kBlack)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
