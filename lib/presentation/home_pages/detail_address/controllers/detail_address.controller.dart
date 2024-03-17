import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/domain/core/model/params/address/address_body.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/controllers/edit_address.controller.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class DetailAddressController extends GetxController {
  final AddressRepository _addressRepository;
  DetailAddressController(this._addressRepository);
  TextEditingController addressController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();

  var actionStatus = ActionStatus.initalize.obs;

  var mainAddress = false.obs;
  bool typeAddress = false;
  final String countryCode = '+62';
  String selectedLabel = "Rumah";
  double latitude = 0.0;
  double longitude = 0.0;
  int? addressId;

  List<String> labels = ["Rumah", "Kantor", "Toko"];

  void onChangeLabel(String value) {
    selectedLabel = value;
    update();
  }

  onChangeMainAddress(bool value) {
    mainAddress(value);
  }

  Future<void> addAddress() async {
    actionStatus(ActionStatus.loading);
    int idCustomer = AppPreference().getUserData()?.user?.id ?? 0;
    var body = AddressBody(
        customerId: idCustomer,
        address: addressController.text,
        lat: latitude,
        lng: longitude,
        label: selectedLabel,
        note: noteController.text,
        personName: nameController.text,
        personPhone: phoneController.text,
        posCode: int.parse(kodePosController.text),
        isMain: mainAddress.value);
    final response = await _addressRepository.addAddress(body);
    if (response.status == StatusResponse.success) {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kBlack,
        duration: 1.seconds,
        borderRadius: 8.r,
        messageText:
            Text('Berhasil menambahkan alamat', style: text12WhiteRegular),
      ));
      actionStatus(ActionStatus.success);

      saveAddress();
      updateAddress();
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kPrimaryColor,
        duration: 1.seconds,
        borderRadius: 8.r,
        messageText:
            Text('Gagal menambahkan alamat', style: text12WhiteRegular),
      ));
      actionStatus(ActionStatus.failed);
    }
  }

  Future<void> editAddress() async {
    actionStatus(ActionStatus.loading);
    int idCustomer = AppPreference().getUserData()?.user?.id ?? 0;
    var body = AddressBody(
        id: addressId ?? 0,
        customerId: idCustomer,
        address: addressController.text,
        lat: latitude,
        lng: longitude,
        label: selectedLabel,
        note: noteController.text,
        personName: nameController.text,
        personPhone: phoneController.text,
        posCode: int.parse(kodePosController.text),
        isMain: mainAddress.value);
    final response = await _addressRepository.editAddress(body);
    if (response.status == StatusResponse.success) {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kBlack,
        duration: 1.seconds,
        borderRadius: 8.r,
        messageText:
            Text('Berhasil mengubah alamat', style: text12WhiteRegular),
      ));
      actionStatus(ActionStatus.success);

      saveAddress();
      updateAddress();
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kPrimaryColor,
        duration: 1.seconds,
        borderRadius: 8.r,
        messageText: Text('Gagal mengubah alamat', style: text12WhiteRegular),
      ));
      actionStatus(ActionStatus.failed);
    }
  }

  List<TextInputFormatter> formaterNumber() => [
        LengthLimitingTextInputFormatter(countryCode.length + 12),
        FilteringTextInputFormatter.deny(RegExp(r'[^\d+]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.startsWith(countryCode)) {
            return newValue;
          }
          return oldValue;
        }),
      ];

  listenPhoneForm(String value) {
    if (value.startsWith('${countryCode}0') &&
        value.length > (countryCode.length + 1)) {
      phoneController.text =
          countryCode + value.substring(countryCode.length + 1);
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
      update();
    }
  }

  void saveAddress() {
    Get.offNamedUntil(
        Routes.EDIT_ADDRESS, (route) => route.settings.name == Routes.CHECKOUT);
  }

  void updateAddress() {
    final controller = Get.find<EditAddressController>();
    controller.pagingController.refresh();
  }

  setData() {
    if (Get.arguments['type'] != 'edit') {
      addressController = TextEditingController(text: Get.arguments['address']);
      kodePosController =
          TextEditingController(text: Get.arguments['pos_code']);
      latitude = Get.arguments['lat'];
      longitude = Get.arguments['lng'];
      typeAddress = true;
      update();
    } else {
      AddressModel data = Get.arguments['address'];
      addressId = data.id;
      addressController = TextEditingController(text: data.address);
      latitude = data.lat ?? 0;
      longitude = data.lng ?? 0;
      nameController = TextEditingController(text: data.personName);
      labelController = TextEditingController(text: data.label);
      phoneController = TextEditingController(text: data.personPhone);
      kodePosController = TextEditingController(text: data.posCode.toString());
      noteController = TextEditingController(text: data.note);
      mainAddress(data.isMain ?? false);
      selectedLabel = data.label ?? 'Rumah';
      typeAddress = false;
      update();
    }
  }

  Future<void> deleteAddress() async {
    final result = await _addressRepository.deleteAddress(addressId ?? 0);
    if (result.result == true) {
      Get.back();
      int idOnCheckout = Get.find<CheckoutController>().address?.id ?? 0;
      bool checkId = addressId == idOnCheckout;

      if (checkId) {
        Get.find<EditAddressController>().pagingController.refresh();
        Get.find<CheckoutController>().setAddress(null);
      } else {
        Get.find<EditAddressController>().pagingController.refresh();
      }
    } else {
      AppSnackbar.show(message: result.message, type: SnackType.error);
    }
  }

  @override
  void onInit() {
    phoneController.text = countryCode;
    setData();
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));

    super.onInit();
  }
}
