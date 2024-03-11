import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/interfaces/ewallet_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/code_before_hash.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widget/topup_form.dart';

class EWalletController extends GetxController {
  final EwalletRepository _ewalletRepository;
  EWalletController(this._ewalletRepository);

  TextEditingController nominalController = TextEditingController();

  PagingController<int, BalanceHistoryModel> pagingController =
      PagingController(firstPageKey: 1);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  static const _pageSize = 10;

  var balance = 0.obs;
  var isShowEwallet = false.obs;

  final String idrPrefix = 'Rp. ';

  var isNominalValue = false.obs;

  Future<void> getBalance() async {
    final response = await _ewalletRepository.getWalletBalance();
    if (response.status == StatusResponse.success) {
      balance.value = response.result ?? 0;
    }
  }

  Future<void> getBalanceHistory(int pageKey) async {
    try {
      final response = await _ewalletRepository.getBalanceHistory(
          page: pageKey, size: _pageSize);
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

  List<dynamic> histories = [];

  void onShowSaldo() {
    isShowEwallet.value = !isShowEwallet.value;
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      pagingController.itemList?.clear();
      pagingController.refresh();
      getBalance();
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController.loadComplete();
  }

  void openFormTopUp() {
    CustomBottomSheet.show(child: TopUpForm(controller: this));
  }

  void listenNominalForm(String value) {
    if (value.isNotEmpty) {
      isNominalValue(true);
    } else {
      isNominalValue(false);
    }
  }

  void toPaymentTopup() {
    Get.back();
    Get.toNamed(Routes.CHOICE_PAYMENT_TOPUP,
        arguments: int.parse(nominalController.text.removeComma));
    nominalController.clear();
  }

  void navigationTo(
      {required int id, required String refId, required String status}) {
    String refCode = refId.getSubstringBeforeHash;
    if (refCode == 'WID' && status == 'WAITING_APPROVAL') {
      Get.toNamed(Routes.WITHDRAW_STATUS, arguments: refId);
    } else if (refCode == 'WID') {
      Get.toNamed(Routes.DETAIL_WITHDRAW, arguments: [refId, null]);
    } else if (refCode == 'ORD') {
      Get.toNamed(Routes.DETAIL_ORDER, arguments: [0, null, null, refId]);
    } else if (refCode == 'BIL') {
      Get.toNamed(Routes.DETAIL_TAGIHAN_BULANAN,
          arguments: [refId, null, null, null]);
    } else if (refCode == 'REF') {
      Get.toNamed(Routes.REFERRAL);
    } else if (refCode == 'LON') {
      Get.toNamed(Routes.DETAIL_PENGAJUAN_PINJAMAN, arguments: [id, null]);
    } else if (refCode == 'SAV') {
      Get.toNamed(Routes.DETAIL_MENABUNG, arguments: [id, null]);
    } else {
      Get.toNamed(Routes.DETAIL_TOPUP, arguments: [refId, null]);
    }
  }

  @override
  void onInit() {
    getBalance();
    pagingController.addPageRequestListener((page) {
      getBalanceHistory(page);
    });
    super.onInit();
  }
}
