import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/bill_paylater_model.dart';

import '../../../../domain/core/interfaces/paylater_repository.dart';

class BillPaylaterController extends GetxController {
  final PayLaterRepository _payLaterRepository;

  BillPaylaterController(this._payLaterRepository);

  PagingController<int, BillPaylaterModel> pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 10;

  Future<void> getBillPaylater(int pageKey) async {
    try {
      final response = await _payLaterRepository.getBillPaylater(
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

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getBillPaylater(page);
    });
    super.onInit();
  }
}
