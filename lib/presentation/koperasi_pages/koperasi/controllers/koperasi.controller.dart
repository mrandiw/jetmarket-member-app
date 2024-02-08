import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/saving_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_history_model.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KoperasiController extends GetxController {
  final SavingRepository _savingRepository;
  KoperasiController(this._savingRepository);

  static const _pageSize = 10;
  int? savingTotal;
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
      getSavingTotal();
      pagingController.refresh();
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController.loadComplete();
  }

  @override
  void onInit() {
    getSavingTotal();
    pagingController.addPageRequestListener((page) {
      getSavingHistory(page);
    });
    super.onInit();
  }
}
