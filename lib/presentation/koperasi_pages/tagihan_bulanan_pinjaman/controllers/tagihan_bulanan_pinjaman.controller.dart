import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_bill_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';

class TagihanBulananPinjamanController extends GetxController {
  final LoanRepository _loanRepository;

  TagihanBulananPinjamanController(this._loanRepository);

  static const _pageSize = 10;
  PagingController<int, LoanBillModel> pagingController =
      PagingController(firstPageKey: 1);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getLoanBill(int pageKey) async {
    try {
      final response =
          await _loanRepository.getLoanBill(page: pageKey, size: _pageSize);
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

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getLoanBill(page);
    });
    super.onInit();
  }
}
