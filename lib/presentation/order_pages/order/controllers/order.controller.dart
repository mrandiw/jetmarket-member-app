import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/order_product_model.dart';
import '../../../../domain/core/model/params/order/list_order_param.dart';
import '../widget/filter_order.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository);
  late TabController tabController;
  static const _pageSize = 2;

  PagingController<int, OrderProductModel> pagingController =
      PagingController(firstPageKey: 1);
  List<RefreshController> refreshController = [];

  var loadingOnChangeTab = false.obs;

  TextEditingController searchController = TextEditingController();
  var currentIndexTab = 0;
  var waitingOrderCustomerLenght = 0.obs;
  String? searchOrder;
  bool searchActived = false;
  bool isFiltered = false;

  dynamic selectedSortOrder;
  dynamic selectedStatusOrder;
  dynamic selectedFilterSortOrder;
  dynamic selectedFilterStatusOrder;

  List<dynamic> sortOrders = [
    {
      'name': 'Terbaru',
      'value': 'latest',
    },
    {
      'name': 'Terlama',
      'value': 'oldest',
    }
  ];

  List<dynamic> statusTabs = [
    {
      'name': 'Sedang Dikemas',
      'value': 'packaging',
    },
    {
      'name': 'Dalam Pengiriman',
      'value': 'on_delivery',
    },
    {
      'name': 'Selesai',
      'value': 'finished',
    },
    {
      'name': 'Dibatalkan',
      'value': 'cancelled',
    },
    {
      'name': 'Pengembalian',
      'value': 'refunded',
    }
  ];

  Future<void> getWaitingOrderLenght() async {
    final response = await _orderRepository.getWaitingOrderLenght();
    if (response.status == StatusResponse.success) {
      waitingOrderCustomerLenght.value = response.result ?? 0;
    }
  }

  Future<void> getListOrderProduct(int pageKey) async {
    try {
      var param = ListOrderParam(
          page: pageKey,
          size: _pageSize,
          name: searchOrder,
          status: selectedStatusOrder['value'],
          sort: selectedSortOrder['value']);
      final response = await _orderRepository.getListOrderProduct(param);

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

  void searchOrders(String value) {
    if (value.isNotEmpty) {
      searchActived = true;
      update();
    } else {
      searchActived = false;
      update();
    }
    searchOrder = value;
    pagingController.refresh();
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterOrder());
  }

  void selectSortOrder(bool select, dynamic value) {
    if (value == selectedSortOrder) {
      selectedSortOrder = null;
      selectedFilterSortOrder = null;
    } else {
      selectedSortOrder = value;
      selectedFilterSortOrder = value;
    }
    update();
  }

  void selectStatusOrder(bool select, dynamic value, int index) {
    if (value == selectedStatusOrder) {
      selectedStatusOrder = null;
      selectedFilterStatusOrder = null;
      currentIndexTab = 0;
      update();
    } else {
      selectedStatusOrder = value;
      selectedFilterStatusOrder = statusTabs[index];
      currentIndexTab = index;
      update();
    }
    update();
  }

  void applyFilterOrder() {
    Get.back();
    tabController.animateTo(currentIndexTab);
    pagingController.refresh();
  }

  void toWaitingPayment() {
    if (waitingOrderCustomerLenght.value > 0) {
      Get.toNamed(Routes.WAITING_PAYMENT);
    }
  }

  Future<void> refreshData() async {
    // searchOrder = null;
    // setFirstFilter();
    // selectedFilterSortOrder = null;
    // selectedFilterStatusOrder = null;
    // currentIndexTab = 0;
    // tabController.animateTo(0);
    pagingController.refresh();
    // update();
  }

  void toDetailOrder(int id) {
    Get.toNamed(Routes.DETAIL_ORDER, arguments: [id, null, null, null]);
  }

  void actionOrder(OrderProductModel data) {
    // data.status == 'REFUNDED'
    //                       ? 'Rincian Pengembalian'
    //                       : data.status == 'WAITING_REFUND_DELIVERY' ||
    //                               data.status == 'REQUEST_REFUND_CUSTOMER'
    //                           ? 'Atur Pengembalian'
    //                           : data.status == 'REFUND_ON_DELIVERY'
    //                               ? 'Lihat Pengembalian'
    //                               : data.status == 'FINISHED'
    //                                   ? 'Review'
    // : 'Beli Lagi',
    if (data.status == 'FINISHED') {
      Get.toNamed(Routes.REVIEW_ORDER, arguments: [data.id, 'review']);
    } else if (data.status == "REFUNDED" ||
        data.status == "REQUEST_REFUND_CUSTOMER") {
      Get.toNamed(Routes.RINCIAN_REFUND, arguments: data.id);
    } else if (data.status == "WAITING_REFUND_DELIVERY") {
      Get.toNamed(Routes.SET_REFUND, arguments: data.id);
    } else if (data.status == 'REFUND_ON_DELIVERY') {
      Get.toNamed(Routes.TRACKING_RETURN, arguments: data.id);
    } else if (data.status == "CANCELLED_BY_COURIER" ||
        data.status == "CANCELLED_BY_SELLER" ||
        data.status == "CANCELLED_BY_SYSTEM" ||
        data.status == "CANCELLED_BY_CUSTOMER") {
      Get.toNamed(Routes.DETAIL_PRODUCT, arguments: [data.id, null]);
    } else {}
  }

  setFirstFilter() {
    selectedSortOrder = {'name': '', 'value': ''};
    selectedStatusOrder = statusTabs[0];
    refreshController =
        List.generate(5, (index) => RefreshController(initialRefresh: false));
  }

  void toTracking(int id, String status) {
    if (status == 'ON_DELIVERY') {
      Get.toNamed(Routes.TRACKING_ORDER, arguments: id);
    } else {
      Get.toNamed(Routes.TRACKING_RETURN, arguments: id);
    }
  }

  setOrderByStatus(int? index) {
    selectedStatusOrder = statusTabs[index ?? 0];
    currentIndexTab = index ?? 0;
    pagingController.itemList?.clear();
    getListOrderProduct(1);
    Future.delayed(1.seconds, () {
      loadingOnChangeTab(false);
      log("${loadingOnChangeTab.value}");
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
    getWaitingOrderLenght();
    pagingController.addPageRequestListener((page) {
      getListOrderProduct(page);
    });
    tabController = TabController(length: 5, vsync: this);
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
