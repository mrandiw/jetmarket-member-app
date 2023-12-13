import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

class DetailAddressController extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var mainAddress = false.obs;
  String selectedLabel = "Rumah";

  List<String> labels = ["Rumah", "Kantor", "Toko"];

  void onChangeLabel(String value) {
    selectedLabel = value;
    update();
  }

  onChangeMainAddress(bool value) {
    mainAddress(value);
  }

  void saveAddress() {
    Get.offNamedUntil(
        Routes.CHECKOUT, (route) => route.settings.name == Routes.CART);
  }

  @override
  void onInit() {
    addressController = TextEditingController(text: Get.arguments['address']);
    super.onInit();
  }
}
