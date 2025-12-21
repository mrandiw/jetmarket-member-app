import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/mandatory_saving_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/mandatory_saving_model.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabunganWajibController extends GetxController {
  final MandatorySavingRepository _repository;
  TabunganWajibController(this._repository);

  static const _pageSize = 10;

  var totalAmount = 0.obs;
  var totalRecords = 0.obs;
  var isLoading = true.obs;

  PagingController<int, MandatorySavingModel> pagingController =
      PagingController(firstPageKey: 1);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getTotalMandatorySaving() async {
    final response = await _repository.getTotalMandatorySaving();
    if (response.status == StatusResponse.success) {
      totalAmount.value = response.result ?? 0;
    }
  }

  Future<void> getMandatorySavingHistory(int pageKey) async {
    try {
      final response = await _repository.getMandatorySavingHistory(
        page: pageKey,
        size: _pageSize,
      );

      if (response.status == StatusResponse.success &&
          response.result != null) {
        final data = response.result!;
        totalAmount.value = data.totalAmount;
        totalRecords.value = data.totalRecords;

        final isLastPage = data.items.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(data.items);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(data.items, nextPageKey);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (error) {
      pagingController.error = error;
    } finally {
      isLoading.value = false;
    }
  }

  void onRefresh() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    pagingController.itemList?.clear();
    pagingController.refresh();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) refreshController.loadComplete();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getMandatorySavingHistory(page);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    refreshController.dispose();
    super.onClose();
  }
}
