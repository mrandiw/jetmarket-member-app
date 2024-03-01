import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/loan_repository.dart';
import 'package:jetmarket/domain/core/interfaces/saving_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_history_model.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/core/model/model_data/loan_bill_check.dart';
import '../../../../infrastructure/navigation/routes.dart';

class KoperasiController extends GetxController {
  final SavingRepository _savingRepository;
  final LoanRepository _loanRepository;
  KoperasiController(this._savingRepository, this._loanRepository);

  static const _pageSize = 10;
  int? savingTotal;
  LoanBillCheckModel? loanBillCheck;
  var isShowEwallet = false.obs;

  PagingController<int, SavingHistoryModel> pagingController =
      PagingController(firstPageKey: 1);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getSavingTotal() async {
    final repository = await _savingRepository.getTotalSaving();
    if (repository.status == StatusResponse.success) {
      savingTotal = repository.result;
      update();
    }
  }

  Future<void> getSavingHistory(int pageKey) async {
    try {
      final response = await _savingRepository.getSavingHistory(
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

  Future<void> getLoanBillCheck() async {
    final repository = await _loanRepository.getLoanBillCheck();
    if (repository.status == StatusResponse.success) {
      loanBillCheck = repository.result;
      update();
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {});
  }

  void onShowSaldo() {
    isShowEwallet.value = !isShowEwallet.value;
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      pagingController.itemList?.clear();
      // getSavingHistory(1);
      getLoanBillCheck();
      getSavingTotal();
      pagingController.refresh();
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController.loadComplete();
  }

  void choicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT_TAGIHAN,
        arguments: [loanBillCheck?.refId, loanBillCheck?.amount]);
  }

  @override
  void onInit() {
    getSavingTotal();
    getLoanBillCheck();
    pagingController.addPageRequestListener((page) {
      getSavingHistory(page);
    });
    super.onInit();
  }
}
