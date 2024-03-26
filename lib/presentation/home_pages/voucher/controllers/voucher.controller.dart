import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/vouchers.dart';
import 'package:jetmarket/utils/extension/percentage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../checkout/controllers/checkout.controller.dart';

class VoucherController extends GetxController {
  final ProductRepository _productRepository;
  VoucherController(this._productRepository);
  TextEditingController searchVoucherController = TextEditingController();
  late PagingController<int, Vouchers> pagingController;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  static const _pageSize = 10;
  List<dynamic> vouchers = [];

  int selectedVoucher = 99;
  Vouchers? selectedVoucherClaim;

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
      selectedVoucher = 99;
      selectedVoucherClaim = null;
      selectedVoucherClaim = response.result;
      actionClaimStatus = ActionStatus.success;
      update();
    } else {
      voucherMessage = response.message ?? 'Kode tidak ditemukan';
      actionClaimStatus = ActionStatus.failed;
      update();
    }
  }

  void selectVoucher(int value) {
    if (selectedVoucher != value) {
      selectedVoucher = value;
      selectedVoucherClaim = pagingController.itemList?[value];
      update();
    } else {
      selectedVoucher = 99;
      selectedVoucherClaim = null;
      update();
    }
  }

  void updateSelectedVoucer() {
    Get.back();
    final controller = Get.find<CheckoutController>();
    if (selectedVoucherClaim?.discount?.startsWith('Rp') ?? false) {
      // Potongan Langsung
      String nominal =
          selectedVoucherClaim?.discount?.replaceAll('Rp', '') ?? '';
      double discountPrice = double.parse(nominal);
      controller.discount = 0.0;
      controller.discountPrice = discountPrice;
    } else {
      // Potongan Cashback
      double discount =
          (selectedVoucherClaim?.discount ?? '').parsePercentageToDouble;
      controller.discountPrice = 0.0;
      controller.discount = discount;
    }

    controller.voucherId = selectedVoucherClaim?.id;
    controller.updateTotalPrice();
    controller.selectVoucher(selectedVoucherClaim?.name ?? '');
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getVoucher(page);
    });

    super.onInit();
  }
}
