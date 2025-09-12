// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/add_address/section/map_view.dart';
import 'controllers/add_address.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';

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
          body: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: Obx(
                  () => controller.locationData.value != null
                      ? MapView(
                          lat: controller.locationData.value?.lat ?? 0.0,
                          lng: controller.locationData.value?.lng ?? 0.0,
                        )
                      : const Center(child: Text("Belum ada lokasi")),
                ),
              ),
            ],
          )),
    );
  }
}
