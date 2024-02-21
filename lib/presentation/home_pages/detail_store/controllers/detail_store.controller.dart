import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_shop.dart';
import 'package:jetmarket/domain/core/model/params/product/product_seller_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../domain/core/model/model_data/category_product.dart';
import '../../../../domain/core/model/model_data/product.dart';

import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../widget/filter_product.dart';

class DetailStoreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ProductRepository _productRepository;
  DetailStoreController(this._productRepository);
  late TabController tabController;
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCategoryController = TextEditingController();
  var screenStatus = (ScreenStatus.success).obs;
  final int _pageSize = 10;

  List<CategoryProduct> categoryProduct = [];
  DetailShop? detailShop;

  late PagingController<int, Product> pagingController;
  String? searchProduct;
  var currentIndexTab = 0.obs;

  List<String> tabs = ['Produk', 'Kategori'];

  String? selectedSortProduct;
  CategoryProduct? selectedCategoryProduct;
  String? selectedStars;
  bool isFiltered = false;

  List<String> sortProduct = [
    'Terbaru',
    'Harga Tertinggi',
    'Harga Terendah',
    'Pembelian Terbanyak'
  ];

  List<String> stars = ["4"];
  setData({required List<CategoryProduct> category, required DetailShop shop}) {
    categoryProduct.assignAll(category);
    detailShop = shop;
    update();
  }

  Future<void> getData(int sellerId) async {
    screenStatus(ScreenStatus.loading);
    final responses = await Future.wait([
      _productRepository.getCategoryProductBySeller(sellerId),
      _productRepository.getDetailShop(sellerId),
    ]);
    if (responses
        .every((response) => response.status == StatusResponse.success)) {
      setData(
        category: responses[0].result as List<CategoryProduct>,
        shop: responses[1].result as DetailShop,
      );
      screenStatus(ScreenStatus.success);
    } else if (responses
        .any((response) => response.status == StatusResponse.timeout)) {
      screenStatus(ScreenStatus.timeout);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  Future<void> getProduct(int pageKey, int sellerId) async {
    try {
      var param = ProductSellerParam(
          page: pageKey,
          size: _pageSize,
          name: searchProduct,
          sellerId: sellerId,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProductBySeller(param);
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
    await Future.delayed(2.seconds, () {
      selectedSortProduct = null;
      selectedCategoryProduct = null;
      selectedStars = null;
      categoryProduct.clear();
      update();
      getData(Get.arguments['seller_id']);
    });
  }

  void searchProducts(String value) {
    searchProduct = value;
    pagingController.refresh();
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterProduct());
  }

  void filterProduct() {}

  void selectSortProduct(bool select, String value) {
    if (value == selectedSortProduct) {
      selectedSortProduct = null;
    } else {
      selectedSortProduct = value;
    }
    update();
  }

  String? convertToEnglish(String? value) {
    switch (value) {
      case 'Terbaru':
        return 'newest';
      case 'Harga Tertinggi':
        return 'highest';
      case 'Harga Terendah':
        return 'lowest';
      case 'Pembelian Terbanyak':
        return 'popular';
      default:
        return null;
    }
  }

  void selectCategoryProduct(bool select, CategoryProduct value) {
    if (value == selectedCategoryProduct) {
      selectedCategoryProduct = null;
    } else {
      selectedCategoryProduct = value;
    }
    update();
  }

  void selectStarts(bool select, String value) {
    if (value == selectedStars) {
      selectedStars = null;
    } else {
      selectedStars = value;
    }
    update();
  }

  void toDetailProduct(int id) {
    Get.toNamed(Routes.DETAIL_PRODUCT, arguments: id);
  }

  void onTapLocationStore() async {
    String mapsUrl =
        "https://www.google.com/maps/search/?api=1&query=${detailShop?.lat}%2C${detailShop?.lng}";
    await launchUrl(Uri.parse(mapsUrl), mode: LaunchMode.externalApplication);
  }

  void backToDetailProduct() {
    if (Get.arguments['product_id'] != null) {
      Get.offAndToNamed(Routes.DETAIL_PRODUCT,
          arguments: [Get.arguments['product_id'], null]);
    } else {
      Get.back();
    }
  }

  void applyFilterProduct() {
    isFiltered = true;
    update();
    Get.back();
    getProduct(1, Get.arguments['seller_id']);
    pagingController.refresh();
  }

  toProductByCategory(int sellerId, CategoryProduct category) {
    Get.toNamed(Routes.PRODUCT_BYCATEGORY,
        arguments: ['store', sellerId, category.id]);
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentIndexTab.value = tabController.index;
    });
    getData(Get.arguments['seller_id']);
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getProduct(page, Get.arguments['seller_id']);
    });
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
