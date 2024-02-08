import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/order_product_model.dart';
import '../../../../domain/core/model/params/order/list_order_param.dart';
import '../../../../infrastructure/navigation/routes.dart';

class ReviewProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final OrderRepository _orderRepository;
  ReviewProductController(this._orderRepository);
  late TabController tabController;
  static const _pageSize = 10;

  PagingController<int, OrderProductModel> pagingController =
      PagingController(firstPageKey: 1);
  List<RefreshController> refreshController = [];

  var loadingOnChangeTab = false.obs;
  dynamic selectedStatusOrder;
  var currentIndexTab = 0;

  List<dynamic> statusTabs = [
    {
      'name': 'Belum Direview',
      'value': 'finished',
    },
    {
      'name': 'Direview',
      'value': 'reviewed',
    }
  ];

  Future<void> getListOrderReview(int pageKey) async {
    try {
      var param = ListOrderParam(
          page: pageKey, size: _pageSize, status: selectedStatusOrder['value']);
      final response = await _orderRepository.getListOrderReview(param);

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

  void selectStatusOrder(bool select, dynamic value, int index) {
    if (value == selectedStatusOrder) {
      selectedStatusOrder = null;
      currentIndexTab = 0;
      update();
    } else {
      selectedStatusOrder = value;
      currentIndexTab = index;
      update();
    }
    update();
  }

  void actionOrder(OrderProductModel data) {
    Get.toNamed(Routes.REVIEW_ORDER, arguments: [data.id, 'review-product']);
  }

  setFirstFilter() {
    selectedStatusOrder = statusTabs[0];
    refreshController =
        List.generate(2, (index) => RefreshController(initialRefresh: false));
  }

  setOrderByStatus(int? index) {
    selectedStatusOrder = statusTabs[index ?? 0];
    currentIndexTab = index ?? 0;
    pagingController.itemList?.clear();
    getListOrderReview(1);
    Future.delayed(1.seconds, () {
      loadingOnChangeTab(false);
    });
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      pagingController.itemList?.clear();
      pagingController.refresh();
      // getListOrderProduct(1);
    });
    refreshController[currentIndexTab].refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController[currentIndexTab].loadComplete();
  }

  @override
  void onInit() {
    setFirstFilter();
    pagingController.addPageRequestListener((page) {
      getListOrderReview(page);
    });
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      // FIX Multiple call tabController
      loadingOnChangeTab(true);
      if (!tabController.indexIsChanging) {
        setOrderByStatus(tabController.index);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    tabController.dispose();
    pagingController.dispose();
    super.dispose();
  }
}
