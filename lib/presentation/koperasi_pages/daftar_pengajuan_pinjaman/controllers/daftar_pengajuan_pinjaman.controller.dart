import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_list_param.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../domain/core/model/model_data/loan_propose_model.dart';

class DaftarPengajuanPinjamanController extends GetxController {
  final LoanRepository _loanRepository;

  DaftarPengajuanPinjamanController(this._loanRepository);
  MenuController? menuController;
  List<String> filters = ['latest', 'oldest'];
  int selectedFilter = 0;

  static const _pageSize = 10;
  PagingController<int, LoanProposeModel> pagingController =
      PagingController(firstPageKey: 1);
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> getLoanPropose(int pageKey) async {
    var param = LoanProposeListParam(
        page: pageKey, size: _pageSize, sortBy: filters[selectedFilter]);
    try {
      final response = await _loanRepository.getLoanPropose(param);
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

  void selectedFilterIndex(int index) {
    selectedFilter = index;
    update();
    pagingController.refresh();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getLoanPropose(page);
    });
    super.onInit();
  }
}
