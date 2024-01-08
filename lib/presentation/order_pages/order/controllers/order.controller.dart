import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/network/status_response.dart';

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
  static const _pageSize = 10;

  PagingController<int, OrderProductModel> pagingController =
      PagingController(firstPageKey: 1);

  TextEditingController searchController = TextEditingController();
  var currentIndexTab = 0;
  var waitingOrderCustomerLenght = 0.obs;
  String? searchOrder;
  bool searchActived = false;

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
    Get.toNamed(Routes.WAITING_PAYMENT);
  }

  Future<void> refreshData() async {
    searchOrder = null;
    setFirstFilter();
    selectedFilterSortOrder = null;
    selectedFilterStatusOrder = null;
    currentIndexTab = 0;
    tabController.animateTo(0);
    pagingController.refresh();
    update();
  }

  void toDetailOrder(int id) {
    Get.toNamed(Routes.DETAIL_ORDER, arguments: [id]);
  }

  void actionOrder(OrderProductModel data) {
    if (data.status == 'FINISHED') {
      Get.toNamed(Routes.REVIEW_ORDER, arguments: [data.id, 'review']);
    } else if (data.status == "REFUNDED") {
      // Get.toNamed(Routes.RINCIAN_REFUND, arguments: data.id);
      Get.toNamed(Routes.SET_REFUND, arguments: data.id);
    } else if (data.status == "REQUEST_REFUND_CUSTOMER") {
      Get.toNamed(Routes.SET_REFUND, arguments: data.id);
    }
  }

  setFirstFilter() {
    selectedSortOrder = {'name': '', 'value': ''};
    selectedStatusOrder = statusTabs[0];
  }

  void toTrackingRefund(int id) {
    Get.toNamed(Routes.TRACKING_RETURN, arguments: id);
    // Get.toNamed(Routes.RINCIAN_REFUND, arguments: id);
    // Get.toNamed(Routes.SET_REFUND, arguments: id);
  }

  setProductByStatus(int? index) {
    selectedStatusOrder = statusTabs[index ?? 0];
    pagingController.refresh();
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
      setProductByStatus(tabController.index);
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
