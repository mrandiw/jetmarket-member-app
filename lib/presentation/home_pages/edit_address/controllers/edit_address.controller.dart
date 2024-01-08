import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/domain/core/model/params/address/address_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

class EditAddressController extends GetxController {
  final AddressRepository _addressRepository;
  EditAddressController(this._addressRepository);
  TextEditingController searchController = TextEditingController();

  late PagingController<int, AddressModel> pagingController;
  static const _pageSize = 10;
  String? searchAddress;
  int selectedAddress = 99;

  Future<void> getAddress(int pageKey) async {
    int idCustomer = AppPreference().getUserData()?.user?.id ?? 0;
    var param = AddressParam(
        page: pageKey,
        size: _pageSize,
        address: searchAddress,
        customerId: idCustomer);
    try {
      final response = await _addressRepository.getAddress(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onSearch(String value) {
    searchAddress = value;
    pagingController.refresh();
  }

  void selectAddress(int value) {
    if (selectedAddress != value) {
      selectedAddress = value;
      update();
    } else {
      selectedAddress = 99;
      update();
    }
  }

  void choiceAddress() {
    print(pagingController.itemList![selectedAddress].id);
    AppPreference().saveAddress(pagingController.itemList![selectedAddress]);
    Get.back();
    final controller = Get.find<CheckoutController>();
    controller.setAddress();
    // controller.selectAddress(pagingController.itemList![selectedAddress]);
  }

  void editAddress(AddressModel data) {
    Get.toNamed(Routes.DETAIL_ADDRESS,
        arguments: {'type': 'edit', 'address': data});
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getAddress(page);
    });
    super.onInit();
  }
}
