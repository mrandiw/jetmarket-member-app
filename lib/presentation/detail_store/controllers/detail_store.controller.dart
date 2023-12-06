import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import '../widget/filter_product.dart';

class DetailStoreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCategoryController = TextEditingController();

  var currentIndexTab = 0.obs;

  List<String> tabs = ['Produk', 'Kategori'];
  String selectedSortProduct = "";
  String selectedCategoryProduct = "";
  String selectedStars = "";

  List<String> sortProduct = [
    'Terbaru',
    'Harga Tertinggi',
    'Harga Terendah',
    'Ulasan Terbanyak',
    'Pembelian Terbanyak'
  ];

  List<String> categoryProduct = [
    'Perlengkapan Sekolah',
    'Elektronik',
    'Kecantikan'
  ];

  List<String> stars = ["4"];

  Future<void> refreshData() async {
    await Future.delayed(1.seconds, () {});
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterProduct());
  }

  void searchProduct() {}

  void filterProduct() {}

  void selectSortProduct(bool select, String value) {
    if (value == selectedSortProduct) {
      selectedSortProduct = "";
    } else {
      selectedSortProduct = value;
    }
    update();
  }

  void selectCategoryProduct(bool select, String value) {
    if (value == selectedCategoryProduct) {
      selectedCategoryProduct = "";
    } else {
      selectedCategoryProduct = value;
    }
    update();
  }

  void selectStarts(bool select, String value) {
    if (value == selectedStars) {
      selectedStars = "";
    } else {
      selectedStars = value;
    }
    update();
  }

  void applyFilterProduct() {
    Get.back();
  }

  toProductByCategory() {
    Get.toNamed(Routes.PRODUCT_BYCATEGORY);
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentIndexTab.value = tabController.index;
    });
    super.onInit();
  }
}
