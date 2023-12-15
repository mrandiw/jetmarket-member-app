import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/product_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/domain/core/model/model_data/product.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../domain/core/model/params/product/product_param.dart';
import '../../../../utils/network/screen_status.dart';
import '../widget/filter_product.dart';

class HomeController extends GetxController {
  final ProductRepository _productRepository;
  HomeController(this._productRepository);
  TextEditingController searchController = TextEditingController();
  var screenStatus = (ScreenStatus.success).obs;
  static const _pageSize = 10;

  List<CategoryProduct> categoryProduct = [];

  PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1);

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

  List<String> categoryProductFilter = [
    'Perlengkapan Sekolah',
    'Elektronik',
    'Kecantikan'
  ];

  List<String> stars = ["4"];

  List<dynamic> listCategory = [
    {"name": "Lihat Semua", "image": allProduct},
    {"name": "Bahan Pokok", "image": bahanPokok},
    {"name": "Minuman", "image": snack},
    {"name": "Snack", "image": snack},
    {"name": "Atk", "image": atk},
    {"name": "Perawatan", "image": perawatan},
    {"name": "Bayi", "image": bayi}
  ];

  setCategory({required List<CategoryProduct> data}) {
    categoryProduct.assignAll(data);
    update();
  }

  Future<void> getCategoryProduct() async {
    final response = await _productRepository.getCategoryProduct();
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
    }
  }

  Future<void> getProduct(int pageKey) async {
    try {
      var param = ProductParam(page: pageKey, size: _pageSize);
      final response = await _productRepository.getProduct(param);
      final isLastPage = response.result!.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + (response.result?.length ?? 0);
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {
      selectedSortProduct = "";
      selectedCategoryProduct = "";
      selectedStars = "";
      update();
      getCategoryProduct();
    });
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

  void toDetailProduct() {
    Get.toNamed(Routes.DETAIL_PRODUCT);
  }

  void applyFilterProduct() {
    Get.back();
  }

  @override
  void onInit() {
    getCategoryProduct();
    pagingController.addPageRequestListener((pageKey) {
      getProduct(pageKey);
    });
    super.onInit();
  }
}
