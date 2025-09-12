import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/add_address/model/location.model.dart';
import 'package:geocoding/geocoding.dart';

enum ResultLocation { success, error, empty, loading }

class AddAddressController extends GetxController {
  String postCode = '';
  double latitude = 0.0;
  double longitude = 0.0;
  final readOnly = false.obs;
  TextEditingController recipientAddressController = TextEditingController();
  GlobalKey<FormState> recipientAddressFormKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateRecipientAddress = AutovalidateMode.disabled;
  TextEditingController labelAddressController = TextEditingController();
  GlobalKey<FormState> labelAddressFormKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateLabelAddress = AutovalidateMode.disabled;
  final Rx<LocationDataModel?> locationData = Rx<LocationDataModel?>(null);

  Future getDataLocation() async {
    try {
      final isAddressValid = recipientAddressFormKey.currentState!.validate();
      final isLableValid = labelAddressFormKey.currentState!.validate();
      if (isAddressValid && isLableValid) {
        List<Location> locations =
            await locationFromAddress(recipientAddressController.text);

        for (var element in locations) {
          latitude = element.latitude;
          longitude = element.longitude;
        }

        List<Placemark> placemarks =
            await placemarkFromCoordinates(latitude, longitude);

        for (var element in placemarks) {
          postCode = element.postalCode ?? '';
        }

        locationData.value = LocationDataModel.fromJson({
          'label': labelAddressController.text,
          'address': '',
          'pos_code': postCode,
          'lat': latitude,
          'lng': longitude
        });

        readOnly.value = true;
      } else {
        if (!isAddressValid) {
          autoValidateRecipientAddress = AutovalidateMode.always;
        }
        if (!isLableValid) {
          autoValidateLabelAddress = AutovalidateMode.always;
        }
      }
    } catch (err) {
      update();
    }
  }

  void backToCheckout() {
    if (Get.arguments != true) {
      Get.back();
    } else {
      Get.back();
      Get.back();
    }
  }
}
