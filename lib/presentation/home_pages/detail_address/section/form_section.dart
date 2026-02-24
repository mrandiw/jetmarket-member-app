import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/location_picker/enhanced_location_picker.dart';
import 'package:jetmarket/presentation/home_pages/detail_address/controllers/detail_address.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailAddressController>(builder: (controller) {
      return Padding(
          padding: AppStyle.paddingAll16,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Address display with map picker button
            Container(
              padding: AppStyle.paddingAll12,
              decoration: BoxDecoration(
                color: kSofterGrey.withValues(alpha: 0.3),
                borderRadius: AppStyle.borderRadius8All,
                border: Border.all(color: kSoftGrey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Alamat',
                        style: text14BlackMedium.copyWith(
                          color: kSoftBlack,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Get.to(() => EnhancedLocationPicker(
                            title: 'Pilih Lokasi Alamat',
                            initialLocation: controller.latitude != 0 && controller.longitude != 0
                                ? LatLng(controller.latitude, controller.longitude)
                                : null,
                            onLocationSelected: (location, address, postalCode) {
                              controller.updateLocation(location.latitude, location.longitude, address);
                              controller.kodePosController.text = postalCode;
                            },
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withValues(alpha: 0.1),
                            borderRadius: AppStyle.borderRadius6All,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.map,
                                size: 16.r,
                                color: kPrimaryColor,
                              ),
                              Gap(4.w),
                              Text(
                                'Pilih di Map',
                                style: text12BlackMedium.copyWith(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Text(
                    controller.addressController.text.isNotEmpty 
                        ? controller.addressController.text
                        : 'Klik "Pilih di Map" untuk memilih lokasi',
                    style: text12BlackRegular.copyWith(
                      color: controller.addressController.text.isNotEmpty 
                          ? kBlack 
                          : kSoftGrey,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
                keyboardType: TextInputType.number),
            Gap(16.h),
            Visibility(
              visible: controller.typeAddress == false,
              child: GestureDetector(
                onTap: () => controller.deleteAddress(),
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
                        colorFilter: const ColorFilter.mode(
                            kPrimaryColor, BlendMode.srcIn),
                      ),
                    ),
                    Gap(8.w),
                    Text('Hapus alamat', style: text12PrimaryRegular)
                  ],
                ),
              ),
            )
          ]));
    });
  }
}
