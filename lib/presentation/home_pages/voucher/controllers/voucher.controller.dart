import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/vouchers.dart';
import 'package:jetmarket/utils/extension/percentage.dart';
import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../checkout/controllers/checkout.controller.dart';

class VoucherController extends GetxController {
  final ProductRepository _productRepository;
  VoucherController(this._productRepository);
  TextEditingController searchVoucherController = TextEditingController();
  late PagingController<int, Vouchers> pagingController;
  static const _pageSize = 10;
  List<dynamic> vouchers = [];

  int selectedVoucher = 99;

  String? voucherMessage;

  var actionClaimStatus = ActionStatus.initalize;

  Future<void> getVoucher(int pageKey) async {
    try {
      final response =
          await _productRepository.getVouchers(page: pageKey, size: _pageSize);
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

  Future<void> checkVoucherCode() async {
    actionClaimStatus = ActionStatus.loading;
    update();
    final response = await _productRepository.claimVoucher(
        code: searchVoucherController.text);
    if (response.status == StatusResponse.success) {
      voucherMessage = response.message ?? '';
      update();
      actionClaimStatus = ActionStatus.success;
      update();
    } else {
      voucherMessage = 'Kode tidak ditemukan';
      actionClaimStatus = ActionStatus.failed;
      update();
    }
  }

  void selectVoucher(int value) {
    if (selectedVoucher != value) {
      selectedVoucher = value;
      update();
    } else {
      selectedVoucher = 99;
      update();
    }
  }

  void updateSelectedVoucer() {
    Get.back();
    double discount =
        (pagingController.itemList?[selectedVoucher].discount ?? '')
            .parsePercentageToDouble;
    final controller = Get.find<CheckoutController>();
    controller.discount = discount;
    controller.updateTotalPrice();
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getVoucher(page);
    });
    vouchers = List.generate(
        3,
        (index) => {
              "title": "Gratis Ongkir ${index + 1}",
              "subtitle": 'Min. Belanja Rp30RB'
            });
    super.onInit();
  }
}
