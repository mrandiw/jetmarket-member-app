// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/location_picker/enhanced_location_picker.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/add_address/controllers/add_address.controller.dart';
import 'package:jetmarket/presentation/home_pages/add_address/model/location.model.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'section/app_bar_section.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: appBarAddAddress,
        body: GetBuilder<AddAddressController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: AppStyle.paddingAll16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label Alamat
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.labelAddressController,
                    label: 'Label Alamat',
                    hintText: 'Contoh: Rumah, Kantor, Kos',
                  ),
                  Gap(16.h),

                  // Location Picker Section
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kPrimaryColor.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: kPrimaryColor,
                                size: 20.r,
                              ),
                              Gap(8.w),
                              Expanded(
                                child: Text(
                                  'Pilih Lokasi Alamat',
                                  style: text14BlackSemiBold.copyWith(
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                              if (controller.latitude != 0 && controller.longitude != 0)
                                GestureDetector(
                                  onTap: () async {
                                    await _showLocationPicker(controller);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 14.r,
                                        ),
                                        Gap(4.w),
                                        Text(
                                          'Ubah',
                                          style: text10HintRegular.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Location Display
                        if (controller.latitude != 0 && controller.longitude != 0)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Address Display
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(color: kSoftGrey),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: kPrimaryColor,
                                            size: 16.r,
                                          ),
                                          Gap(8.w),
                                          Expanded(
                                            child: Text(
                                              'Alamat Terpilih',
                                              style: text12BlackMedium.copyWith(
                                                color: kSoftBlack,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(8.h),
                                      if (controller.recipientAddressController.text.isNotEmpty)
                                        Text(
                                          controller.recipientAddressController.text,
                                          style: text12BlackRegular,
                                        )
                                      else
                                        Text(
                                          'Alamat akan muncul di sini setelah memilih lokasi',
                                          style: text12HintRegular.copyWith(
                                            color: kSoftGrey,
                                          ),
                                        ),
                                      if (controller.postCode.isNotEmpty) ...[
                                        Gap(4.h),
                                        Text(
                                          'Kode Pos: ${controller.postCode}',
                                          style: text12HintRegular,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Gap(12.h),

                                // Coordinates
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: kGrey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.gps_fixed,
                                        color: kSoftGrey,
                                        size: 16.r,
                                      ),
                                      Gap(8.w),
                                      Text(
                                        'Koordinat: ${controller.latitude.toStringAsFixed(6)}, ${controller.longitude.toStringAsFixed(6)}',
                                        style: text10HintRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(32.w),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.location_off,
                                  size: 48.r,
                                  color: kSoftGrey,
                                ),
                                Gap(12.h),
                                Text(
                                  'Belum ada lokasi yang dipilih',
                                  style: text14BlackRegular.copyWith(
                                    color: kSoftGrey,
                                  ),
                                ),
                                Gap(8.h),
                                Text(
                                  'Tekan tombol di bawah untuk memilih lokasi',
                                  style: text12HintRegular,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                        // Select Location Button
                        if (controller.latitude == 0 || controller.longitude == 0)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await _showLocationPicker(controller);
                                },
                                icon: const Icon(Icons.map),
                                label: Text(
                                  'Pilih Lokasi di Map',
                                  style: text14BlackSemiBold,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimaryColor,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Gap(20.h),

                  // Alamat Manual (Opsional - untuk detail tambahan)
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.recipientAddressController,
                    label: 'Alamat Detail (Opsional)',
                    hintText: 'Contoh: No. rumah, RT/RW, nama jalan',
                  ),
                  Gap(16.h),

                  // Catatan untuk Kurir
                  AppForm(
                    type: AppFormType.withLabel,
                    controller: controller.noteController,
                    label: 'Catatan untuk Kurir (Opsional)',
                    hintText: 'Contoh: Warna rumah, patokan, dll',
                  ),
                  Gap(24.h),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateForm(controller)) {
                          // Buat LocationDataModel dari data yang ada
                          final locationData = LocationDataModel(
                            label: controller.labelAddressController.text,
                            address: controller.recipientAddressController.text,
                            posCode: controller.postCode,
                            lat: controller.latitude,
                            lng: controller.longitude,
                            notes: controller.noteController.text, // Tambah catatan kurir
                          );
                          
                          final jsonData = locationData.toJson();
                          debugPrint('AddAddress sending data: $jsonData');
                          
                          // Navigasi ke detail_address dengan data lokasi
                          Get.toNamed(
                            Routes.DETAIL_ADDRESS,
                            arguments: jsonData,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Lanjutkan',
                        style: text16BlackSemiBold,
                      ),
                    ),
                  ),
                  Gap(16.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showLocationPicker(AddAddressController controller) async {
    final result = await Get.to<Map<String, dynamic>>(
      () => EnhancedLocationPicker(
        title: 'Pilih Lokasi Alamat',
        initialLocation: controller.latitude != 0 && controller.longitude != 0
            ? LatLng(controller.latitude, controller.longitude)
            : null,
        onLocationSelected: (location, address, postalCode) {
          controller.latitude = location.latitude;
          controller.longitude = location.longitude;
          controller.recipientAddressController.text = address;
          controller.postCode = postalCode;
          controller.update();
          return {
            'location': location,
            'address': address,
            'postalCode': postalCode,
          };
        },
      ),
    );

    if (result != null) {
      // Data sudah terupdate di dalam onLocationSelected
      controller.update();
    }
  }

  bool _validateForm(AddAddressController controller) {
    if (controller.labelAddressController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Label alamat tidak boleh kosong',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
      return false;
    }

    if (controller.latitude == 0 || controller.longitude == 0) {
      Get.snackbar(
        'Error',
        'Silakan pilih lokasi terlebih dahulu',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
      return false;
    }

    if (controller.recipientAddressController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Alamat tidak boleh kosong',
        backgroundColor: kErrorColor,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }
}
