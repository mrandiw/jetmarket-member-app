import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/product_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/domain/core/model/model_data/product.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../domain/core/model/model_data/banner.dart';
import '../../../../domain/core/model/params/product/product_param.dart';
import '../../../../domain/core/model/params/product/product_seller_param.dart';
import '../../../../utils/network/screen_status.dart';
import '../widget/filter_product.dart';

class HomeController extends GetxController {
  final ProductRepository _productRepository;
  HomeController(this._productRepository);
  TextEditingController searchController = TextEditingController();
  var screenStatus = (ScreenStatus.success).obs;
  var isHomeScreen = true.obs;
  static const _pageSize = 10;
  static const _pagePopularSize = 10;

  late PagingController<int, Product> pagingController;
  late PagingController<int, Product> pagingPopularController;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<CategoryProduct> categoryProduct = [];
  List<Banners> banners = [];
  List<Product> popularProducts = [];

  String? searchProduct;
  bool searchActived = false;

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

  setBanner({required List<Banners> data}) {
    banners.assignAll(data);
    update();
  }

  setCategory({required List<CategoryProduct> data}) {
    categoryProduct.assignAll(data);
    update();
  }

  setPopular({required List<Product> data}) {
    popularProducts.assignAll(data);
    update();
  }

  Future<void> getBanner() async {
    final response = await _productRepository.getBanner();
    if (response.status == StatusResponse.success) {
      setBanner(data: response.result ?? []);
    }
  }

  Future<void> getCategoryProduct() async {
    final response = await _productRepository.getCategoryProduct();
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
    }
  }

  Future<void> getPopularProduct() async {
    var param = const ProductSellerParam(page: 1, size: 10, sellerId: 1);
    final response = await _productRepository.getProductBySeller(param);
    if (response.status == StatusResponse.success) {
      setPopular(data: response.result ?? []);
    }
  }

  Future<void> getProduct(int pageKey) async {
    try {
      var param = ProductParam(
          page: pageKey,
          size: _pageSize,
          name: searchProduct,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProduct(param);
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

  Future<void> getProductPopularOnPage(int pageKey) async {
    try {
      var param = ProductSellerParam(
          page: pageKey,
          size: _pagePopularSize,
          sellerId: 1,
          name: searchProduct,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProductBySeller(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingPopularController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingPopularController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingPopularController.error = error;
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {
      selectedSortProduct = null;
      selectedCategoryProduct = null;
      selectedStars = null;
      searchProduct = null;
      searchController.clear();
      categoryProduct.clear();
      banners.clear();
      popularProducts.clear();
      update();
      getBanner();
      getCategoryProduct();
      getPopularProduct();
    });
  }

  void seeAllPopular() {
    selectedSortProduct = null;
    selectedCategoryProduct = null;
    selectedStars = null;
    searchProduct = null;
    searchController.clear();
    searchActived = false;
    update();
    isHomeScreen.value = !isHomeScreen.value;

    if (isHomeScreen.value == true) {
      pagingController.refresh();
      pagingPopularController.refresh();

      refreshData();
    } else {
      pagingPopularController.refresh();
    }
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterProduct());
  }

  void searchProducts(String value) {
    if (value.isNotEmpty) {
      searchActived = true;
      update();
    } else {
      searchActived = false;
      update();
    }
    searchProduct = value;
    if (isHomeScreen.value) {
      pagingController.refresh();
    } else {
      pagingPopularController.refresh();
    }
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

  void toCategoryProduct(int id, int index) {
    if (index == 0) {
      Get.toNamed(Routes.ALL_CATEGORY);
    } else {
      Get.toNamed(Routes.PRODUCT_BYCATEGORY, arguments: ['home', 0, id]);
    }
  }

  void toDetailProduct(int id) {
    Get.toNamed(Routes.DETAIL_PRODUCT, arguments: [id, null]);
  }

  void applyFilterProduct() {
    isFiltered = true;
    update();
    Get.back();
    if (isHomeScreen.value) {
      // getProduct(1);
      pagingController.refresh();
    } else {
      // getProductPopularOnPage(1);
      pagingPopularController.refresh();
    }
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      pagingController.itemList?.clear();
      // getSavingHistory(1);
      if (isHomeScreen.value) {
        pagingController.refresh();
      } else {
        pagingPopularController.refresh();
      }
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController.loadComplete();
  }

  void onTapBanner(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  void onInit() {
    getBanner();
    getCategoryProduct();
    getPopularProduct();
    pagingController = PagingController(firstPageKey: 1);
    pagingPopularController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getProduct(page);
    });

    pagingPopularController.addPageRequestListener((page) {
      getProductPopularOnPage(page);
    });

    super.onInit();
  }
}
